#!/usr/bin/env python3
"""Split an IPAC-style text table into one schema file and data parts.

Outputs, for an input named ``stellar_data.txt``:

    stellar_data_columns.txt
    stellar_data_part_1.txt
    stellar_data_part_2.txt
    stellar_data_part_3.txt
    stellar_data_part_4.txt

The columns file contains the descriptive preamble and the pipe-delimited
schema lines, but no data rows. Each data part begins with the same schema
lines and contains approximately the same number of data rows.
"""

from __future__ import annotations

import argparse
from contextlib import ExitStack
from pathlib import Path
from typing import BinaryIO


def is_schema_line(line: bytes) -> bool:
    """Return True for an IPAC table schema line such as ``| kepid | ... |``."""
    return line.lstrip().startswith(b"|")


def inspect_table(input_path: Path) -> tuple[list[bytes], list[bytes], int]:
    """Read the preamble/schema and count non-empty data rows."""
    preamble: list[bytes] = []
    schema: list[bytes] = []
    data_rows = 0
    state = "preamble"

    with input_path.open("rb") as source:
        for line in source:
            if state == "preamble":
                if is_schema_line(line):
                    state = "schema"
                    schema.append(line)
                else:
                    preamble.append(line)
                continue

            if state == "schema":
                if is_schema_line(line):
                    schema.append(line)
                    continue
                state = "data"

            # Blank lines are not table records.
            if line.strip():
                data_rows += 1

    if not schema:
        raise ValueError(
            "No IPAC schema lines were found. Expected one or more lines "
            "whose first non-space character is '|'."
        )
    if data_rows == 0:
        raise ValueError("The table contains no data rows after the schema.")

    return preamble, schema, data_rows


def rows_per_part(total_rows: int, number_of_parts: int) -> list[int]:
    """Distribute rows as evenly as possible among the output parts."""
    base, remainder = divmod(total_rows, number_of_parts)
    return [base + (1 if index < remainder else 0) for index in range(number_of_parts)]


def write_columns_file(
    output_path: Path, preamble: list[bytes], schema: list[bytes]
) -> None:
    """Write descriptive column information and schema, without data rows."""
    with output_path.open("wb") as output:
        output.writelines(preamble)
        output.writelines(schema)


def write_data_parts(
    input_path: Path,
    output_paths: list[Path],
    schema: list[bytes],
    part_sizes: list[int],
) -> None:
    """Stream data rows into the requested output files."""
    with ExitStack() as stack:
        outputs: list[BinaryIO] = [
            stack.enter_context(path.open("wb")) for path in output_paths
        ]
        for output in outputs:
            output.writelines(schema)

        part_index = 0
        rows_written_to_part = 0
        state = "preamble"

        with input_path.open("rb") as source:
            for line in source:
                if state == "preamble":
                    if is_schema_line(line):
                        state = "schema"
                    continue

                if state == "schema":
                    if is_schema_line(line):
                        continue
                    state = "data"

                if not line.strip():
                    continue

                while (
                    part_index < len(part_sizes) - 1
                    and rows_written_to_part >= part_sizes[part_index]
                ):
                    part_index += 1
                    rows_written_to_part = 0

                outputs[part_index].write(line)
                rows_written_to_part += 1


def split_table(input_path: Path, output_dir: Path, parts: int = 4) -> list[Path]:
    """Create one columns file plus ``parts`` data files."""
    if parts < 1:
        raise ValueError("The number of data parts must be at least 1.")
    if not input_path.is_file():
        raise FileNotFoundError(f"Input file not found: {input_path}")

    output_dir.mkdir(parents=True, exist_ok=True)
    preamble, schema, total_rows = inspect_table(input_path)
    part_sizes = rows_per_part(total_rows, parts)

    stem = input_path.stem
    columns_path = output_dir / f"{stem}_columns.txt"
    part_paths = [
        output_dir / f"{stem}_part_{index}.txt" for index in range(1, parts + 1)
    ]

    write_columns_file(columns_path, preamble, schema)
    write_data_parts(input_path, part_paths, schema, part_sizes)

    print(f"Columns file: {columns_path}")
    for path, size in zip(part_paths, part_sizes):
        print(f"Data part:    {path} ({size} rows)")

    return [columns_path, *part_paths]


def parse_arguments() -> argparse.Namespace:
    parser = argparse.ArgumentParser(
        description=(
            "Split an IPAC-style text table into one columns/schema file "
            "and evenly sized data files."
        )
    )
    parser.add_argument("input_file", type=Path, help="Path to stellar_data.txt")
    parser.add_argument(
        "-o",
        "--output-dir",
        type=Path,
        default=None,
        help="Output directory; defaults to the input file's directory.",
    )
    parser.add_argument(
        "-p",
        "--parts",
        type=int,
        default=4,
        help="Number of data parts to create (default: 4).",
    )
    return parser.parse_args()


def main() -> None:
    args = parse_arguments()
    output_dir = args.output_dir or args.input_file.resolve().parent

    try:
        split_table(args.input_file.resolve(), output_dir.resolve(), args.parts)
    except (OSError, ValueError) as error:
        raise SystemExit(f"Error: {error}") from error


if __name__ == "__main__":
    main()
