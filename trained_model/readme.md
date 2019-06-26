manifold_GA

Copyright (c) 2019 Russell Fung & Abbas Ourmazd. All Rights Reserved.

Trained model(s) go here.

Each trained model consists of
(1) an appropriately named subdirectory containing all the relevant files. 
(2) one NLSA-reconstructed time-series of (AC,FL,HC) in "squeezed_reconstructed_data.mat".
(3) for each length-scale of interest (\sigma), 
  (a) the diffusion map embedding of the time-series & normalization factors in 
  "training_info_nS*_nN*_sigma*_nEigs*.mat", and
  (b) the expansion coefficients in "c_coeff_info_nS*_nN*_sigma*_nEigs*.mat".
  
For example, for the trained model "180403d_8145", we have
(1) a subdirectory named "180403d_8145", within which there are
(2) one file named "squeezed_reconstructed_data.mat".
(3a) twenty-two "training_info_nS1713_nN300_sigma*_nEigs100.mat" files, one for each length-scale of interest (\sigma).
(3b) twenty-two "c_coeff_info_nS1713_nN300_sigma*_nEigs100.mat" files, one for each length-scale of interest (\sigma).
