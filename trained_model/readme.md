<h1>manifold-GA</h1>

Copyright (c) 2019 Russell Fung & Abbas Ourmazd. All Rights Reserved.

Trained model(s) go here.

Each trained model consists of
<ol type="i">
  <li>an appropriately named subdirectory containing all the relevant files.</li>
  <li>one NLSA-reconstructed time-series of (AC,FL,HC) in <b>squeezed_reconstructed_data.mat</b>.</li>
  <li>for each length-scale of interest (&sigma;),
    <ul>
    <li>the diffusion map embedding of the time-series & normalization factors in
      <b>training_info_nS*_nN*_sigma*_nEigs*.mat</b>, and</li>
    <li>the expansion coefficients in <b>c_coeff_info_nS*_nN*_sigma*_nEigs*.mat</b></li>
    </ul>
  </li>
</ol>

For example, for the trained model <b>180403d_8145</b>, we have
  <ol type="i">
  <li>a subdirectory named <b>180403d_8145</b>, within which are</li>
  <li>one file named <b>squeezed_reconstructed_data.mat</b>, and</li>
  <li>twenty-two <b>training_info_nS1713_nN300_sigma*_nEigs100.mat</b> &
    <b>c_coeff_info_nS1713_nN300_sigma*_nEigs100.mat</b> files, for the 22 length-scales
    (&sigma;) the model has been extended to cover.</li>
  </ol>

Download trained model(s) <a href="https://www.synapse.org/#!Synapse:syn20081375/files/">here</a>.
