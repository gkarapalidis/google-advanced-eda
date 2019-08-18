---


---

<h1 id="advanced-eda-for-google-analytics">Advanced EDA for Google Analytics</h1>
<p>Hi! This is my first ShinyApp and its purpose is to help analyse data from Google Analytics easily and quickly.<br>
This app is purely an experiment and a way for me to become more familiar with R, Shiny and statistical models.<br>
Inspiration was taken from a Shiny demo dashboard <a href="https://github.com/MarkEdmondson1234">Mark Edmondson</a> created.</p>
<p>Its supports app to two metrics at the same time and you can perform the below exploratory and predictive analysis.</p>
<ol>
<li>Performance over time for up to two metrics and Google updates annotations for reference.</li>
<li>Extraction of seasonality using time series decomposition</li>
<li>Forecasting using Facebook Prophet</li>
<li>Anomaly detection</li>
<li>Causal effect analysis (in development)</li>
<li>Weather correlations (in development)</li>
</ol>
<p>I will keep developing the app and continue making changes to the UI and features.</p>
<p><img src="https://lh3.googleusercontent.com/3OXPPsYZeviYKZwUt_ktvN3kpN-7HW-RMOSqvdVEGzZtUagIAyuYnttbDyRPqYbGIxWHC7BmfbiW" alt="enter image description here"></p>
<p><a href="https://karapalidis.com/advanced-eda/">Demo</a></p>
<h2 id="packages">Packages</h2>
<p>Packages currently in use listed below and links to all the original sources provided for reference.</p>
<p><strong>Shiny libraries</strong><br>
<a href="https://github.com/rstudio/shiny">shiny</a> (1.3.2.9001)<br>
<a href="https://github.com/daattali/shinyjs">shinyjs</a> (1.0)<br>
<a href="https://github.com/AnalytixWare/ShinySky">shinysky</a> (0.1.2)<br>
<a href="https://github.com/rstudio/shinythemes">shinythemes</a> (1.1.2)<br>
<a href="https://github.com/dreamRs/shinyWidgets">shinyWidgets</a> (0.4.8)<br>
<a href="https://github.com/dreamRs/shinybusy">shinybusy</a> (0.1.2)<br>
<a href="https://github.com/rstudio/rsconnect">rsconnect</a> (0.8.15)</p>
<p><strong>Google API libraries</strong><br>
<a href="https://code.markedmondson.me/googleAuthR/">googleAuthR</a> (0.8.1)<br>
<a href="https://code.markedmondson.me/googleAnalyticsR/">googleAnalyticsR</a> (0.6.0)</p>
<p><strong>Graph libraries</strong><br>
<a href="https://github.com/rstudio/dygraphs">dygraphs</a> (1.1.1.6)<br>
<a href="https://cran.r-project.org/web/packages/ggplot2/index.html">ggplot2</a> (3.2.1)<br>
<a href="https://cran.r-project.org/web/packages/plotly/index.html">plotly</a> (4.9.0)<br>
<a href="https://github.com/rstudio/d3heatmap">d3heatmap</a> (0.6.1.2)</p>
<p><strong>Models and time series</strong><br>
<a href="https://facebook.github.io/prophet/">prophet</a> (0.5)<br>
<a href="https://github.com/twitter/AnomalyDetection">AnomalyDetection</a> (1.0)<br>
<a href="https://github.com/google/CausalImpact">CausalImpact</a> (1.2.3)<br>
<a href="https://cran.r-project.org/web/packages/xts/index.html">xts</a> (0.11-2)<br>
<a href="https://cran.r-project.org/web/packages/tseries/index.html">tseries</a> (0.10-47)<br>
<a href="https://cran.r-project.org/web/packages/zoo/index.html">zoo</a> (1.8-6)</p>
<p><strong>Data manipulation</strong><br>
<a href="https://uc-r.github.io/tidyr">tidyr</a> (0.8.3)<br>
<a href="https://cran.rstudio.com/web/packages/lubridate/lubridate.pdf">lubridate</a> (1.7.4)<br>
<a href="https://cran.r-project.org/web/packages/stringr/vignettes/stringr.html">stringr</a> (1.4.0)<br>
<a href="https://cran.r-project.org/web/packages/dplyr/vignettes/dplyr.html">dplyr</a> (0.8.3)<br>
<a href="https://cran.r-project.org/web/packages/data.table/vignettes/datatable-intro.html">data.table</a> (1.12.2)<br>
<a href="https://rstudio.github.io/DT/">DT</a> (0.8)</p>

