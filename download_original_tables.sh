# Kepler Stellar Data 
# Reference page: https://exoplanetarchive.ipac.caltech.edu/docs/Kepler_stellar_docs.html
# Download Stellar Data
wget -O stellar_data.txt "https://exoplanetarchive.ipac.caltech.edu/cgi-bin/nstedAPI/nph-nstedAPI?table=q1_q17_dr25_stellar&format=ipac&select=*"
# Download Stellar Suppemental Data
wget -O stellar_supp_data.txt "https://exoplanetarchive.ipac.caltech.edu/cgi-bin/nstedAPI/nph-nstedAPI?table=q1_q17_dr25_supp_stellar&format=ipac&select=*"


# Simulated Data for Completeness and Reliability
# Reference page: https://exoplanetarchive.ipac.caltech.edu/docs/KeplerSimulated.html
# Average Detection Efficiency table
wget -O avg_detection_eff_INJ1.txt "https://exoplanetarchive.ipac.caltech.edu/data/KeplerData/Simulated/kplr_dr25_inj1_plti.txt"
# Robovetter Results table
# INJ1
wget -O robovetter_results_INJ1.txt "https://exoplanetarchive.ipac.caltech.edu/data/KeplerData/Simulated/kplr_dr25_inj1_tces.txt"
# INV
wget -O robovetter_results_INV.txt "https://exoplanetarchive.ipac.caltech.edu/data/KeplerData/Simulated/kplr_dr25_inv_tces.txt"
# SCR1
wget -O robovetter_results_SCR1.txt "https://exoplanetarchive.ipac.caltech.edu/data/KeplerData/Simulated/kplr_dr25_scr1_tces.txt"
# SCR2
wget -O robovetter_results_SCR2.txt "https://exoplanetarchive.ipac.caltech.edu/data/KeplerData/Simulated/kplr_dr25_scr2_tces.txt"
# SCR3
wget -O robovetter_results_SCR3.txt "https://exoplanetarchive.ipac.caltech.edu/data/KeplerData/Simulated/kplr_dr25_scr3_tces.txt"


# Berger et al. 2020a
# Reference pages:	https://doi.org/10.3847/1538-3881/159/6/280  |  https://arxiv.org/abs/2001.07737v3
# Table 1
wget -O berger_2020a_t1.txt "https://content.cld.iop.org/journals/1538-3881/159/6/280/revision1/ajab8a33t1_mrt.txt"
# Table 2
wget -O berger_2020a_t2.txt "https://content.cld.iop.org/journals/1538-3881/159/6/280/revision1/ajab8a33t2_mrt.txt"


# Berger et al. 2020b
# Reference pages:	https://doi.org/10.3847/1538-3881/aba18a  |  https://arxiv.org/abs/2005.14671
wget -O berger_2020b_t1.txt "https://content.cld.iop.org/journals/1538-3881/160/3/108/revision1/ajaba18at1_mrt.txt"


# Petigura et al. 2022
# Reference pages:	https://doi.org/10.3847/1538-3881/ac51e3  |  https://arxiv.org/abs/2201.10020
# Table 1
wget -O petigura_2022_t1.txt "https://content.cld.iop.org/journals/1538-3881/163/4/179/revision1/ajac51e3t1_mrt.txt"
# Table 2
wget -O petigura_2022_t2.txt "https://content.cld.iop.org/journals/1538-3881/163/4/179/revision1/ajac51e3t2_mrt.txt"
# Table 3
wget -O petigura_2022_t3.txt "https://iopscience.iop.org/1538-3881/163/4/179/suppdata/ajac51e3t3_ascii.txt?doi=10.3847/1538-3881/ac51e3"
# Table 4
wget -O petigura_2022_t4.txt "https://iopscience.iop.org/1538-3881/163/4/179/suppdata/ajac51e3t4_ascii.txt?doi=10.3847/1538-3881/ac51e3"

# Berger at al. B23 Gaia DR3 tables
wget -O b23_table2_stellar.csv "https://arxiv.org/src/2301.11338v1/anc/GKTHCatalog_Table2.csv"
wget -O b23_table4.csv "https://arxiv.org/src/2301.11338v1/anc/GKTHCatalog_Table4.csv"
wget -O b23_table5.csv "https://arxiv.org/src/2301.11338v1/anc/GKTHCatalog_Table5.csv"
