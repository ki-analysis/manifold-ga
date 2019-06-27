<h1>manifold-GA</h1>

Copyright (c) 2019 Russell Fung & Abbas Ourmazd. All Rights Reserved.

<h2>manifold-GA files & directory structure</h2>
<ol type="1">
<li>Download the following MATLAB&reg; m-files, and place them in a directory named <b>manifold-ga</b>.</li>
  <ol type="a">
  <li><b>dmat.m</b></li>
  <li><b>parse_string.m</b></li>
  <li><b>plotRF_integer_bar_chart.m</b></li>
  <li><b>update_preference.m</b></li>
  <li><b>manifold_GA.m</b></li>
  <li><b>manifold_GA_2_visits.m</b></li>
  </ol>
<li>Inside the <b>manifold-ga</b> directory, create a subdirectory named <b>trained_model</b>.</li>
<li>Inside the <b>trained_model</b> directory, MATLAB&reg; mat-files for each trained model must be placed together in an
appropriately named subdirectory. These mat-files can be downloaded 
<a href="https://www.synapse.org/#!Synapse:syn20081375/files/">here</a>.</li>
<li>The trained model <b>180403d_8145</b> is used by default, and must be present if no other trained model is explicitly
specified.</li>
<li>Each trained model consists of
  <ol type="i">
  <li>an appropriatedly named subdirectory.</li>
  <li>one NLSA-reconstructed time-series of (AC,FL,HC) in <b>squeezed_reconstructed_data.mat</b>.</li>
  <li>for each length-scale of interest (&sigma;),
    <ul>
    <li>the diffusion map embedding of the time-series & normalization factors in
      <b>training_info_nS*_nN*_sigma*_nEigs*.mat</b>, and</li>
    <li>the expansion coefficients in <b>c_coeff_info_nS*_nN*_sigma*_nEigs*.mat</b></li>
    </ul>
  </li>
  </ol>
<li>For example, for the trained model <b>180403d_8145</b>, we have
  <ol type="i">
  <li>a subdirectory named <b>180403d_8145</b>, within which are</li>
  <li>one file named <b>squeezed_reconstructed_data.mat</b>, and</li>
  <li>twenty-two <b>training_info_nS1713_nN300_sigma*_nEigs100.mat</b> &  
    <b>c_coeff_info_nS1713_nN300_sigma*_nEigs100.mat</b> files, for the 22 length-scales (&sigma;) the model
    has been extended to cover.</li>
  </ol>
</ol>

<h2>running manifold-GA</h2>
<ol type="1">
<li>One prenatal visit, with a GUI:
  <pre>>> manifold_GA</pre>
<li>One prenatal visit, without a GUI:
  <pre>>> T=[16.17 3.61 18.45]; manifold_GA</pre>
  Here the Abdominal Circumference (AC), Femur Length (FL), and Head Circumference (HC), in this order, are specified in cm
  in the MATLAB&reg; variable <b>T</b>.
<li>A different trained model can be used, with or without a GUI:
  <pre>>> system_of_interest='180403i_9565'; manifold_GA</pre>
  <pre>>> system_of_interest='180402h_1732'; T=[16.17 3.61 18.45]; manifold_GA</pre>
  In these cases, the specified trained models must be present (see above).</li>
<li>In each of these cases, a histogram of candidate predictions (with different values of &sigma; and numbers of 
  eigenfunctions) is shown, and a text message will appear in the MATLAB&reg; window.
<li>If a definitive prediction is possible, the corresponding histogram bar will be highlighted in red.</li>
<li>Two prenatal visits of the same subject, with a GUI:
  <pre>>> manifold_GA_2_visits</pre>
<li>Two prenatal visits of the same subject, without a GUI:
  <pre>>> T=[22.24 4.34 23.06; 29.21 5.53 28.70]; dt=35; manifold_GA_2_visits</pre>
  Here AC, FL, and HC for the first visit, and AC, FL, and HC for the second visit, in this order, are specified in cm in 
  the MATLAB&reg; variable <b>T</b>. Note the use of semi-colon, making <b>T</b> a 2 x 3 matrix. The time elapsed between
  the two visits are specified in days in the MATLAB&reg; variable <b>dt</b>.
<li>A different trained model can be used, with or without a GUI:
  <pre>>> system_of_interest='180403i_9565'; manifold_GA_2_visits</pre>
  <pre>>> system_of_interest='180402h_1732'; T=[22.24 4.34 23.06; 29.21 5.53 28.70]; dt=35; manifold_GA_2_visits</pre>
  In these cases, the specified trained models must be present (see above).</li>
<li>In each of these cases, a histogram of candidate predictions (with different values of &sigma; and numbers of 
  eigenfunctions, and interval matched to within 1 day of the best match) is shown, and a text message will appear in 
  the MATLAB&reg; window.
<li>The histogram bar corresponding to the prediction with the best interval match is highlighted.</li>
</ol>
