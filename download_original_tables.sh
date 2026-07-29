# Kepler Stellar Data 
# Reference page: https://exoplanetarchive.ipac.caltech.edu/docs/Kepler_stellar_docs.html
# Download Stellar Data
wget -O stellar_data.txt "https://exoplanetarchive.ipac.caltech.edu/cgi-bin/nstedAPI/nph-nstedAPI?table=q1_q17_dr25_stellar&format=ipac&select=*"
# Download Stellar Suppemental Data
wget -O stellar_supp_data.txt "https://exoplanetarchive.ipac.caltech.edu/cgi-bin/nstedAPI/nph-nstedAPI?table=q1_q17_dr25_supp_stellar%20&format=ipac&select=*"


# Simulated Data for Completeness and Reliability
# Reference page: https://exoplanetarchive.ipac.caltech.edu/docs/KeplerSimulated.html
# Average Detection Efficiency table
wget -O avg_detection_eff_INJ1.txt "https://exoplanetarchive.ipac.caltech.edu/data/KeplerData/Simulated/kplr_dr25_inj1_plti.txt"
# Robovetter Results table
wget -O robovetter_results.txt "https://exoplanetarchive.ipac.caltech.edu/data/KeplerData/Simulated/kplr_dr25_inj1_tces.txt"
