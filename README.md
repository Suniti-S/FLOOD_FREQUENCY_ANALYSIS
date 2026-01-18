# Flood Frequency Analysis in R Using L-Moments (lmomco Package)

This repository contains an R script for performing **flood-frequency analysis** using annual maximum discharge values. The workflow includes reading hydrological data, computing L-moments, fitting probability distributions, estimating return-period floods, and generating formatted result tables.

The method is based on the **lmomco** package by W.H. Asquith, which uses L-moments to fit distributions commonly used in hydrology.

This script performs flood frequency analysis using annual maximum discharge data. The analysis includes:
   - Reading hydrological data from a text file
   - Computing L-moments using lmomco
   - Fitting multiple probability distributions
   - Estimating return-period flood values
   - Generating tables using gt package
   - Optional histogram + normal distribution fit

 ------------------------------------------------------------------------------

# FEATURES:

1. Data Input & Visualization
   - Reads .txt data with Year + Annual Maximum Discharge
   - Plots bar chart of max floods

2. L-Moment Computation
   L-moments are calculated using:
       lmom <- lmoms(data$Qmaks)

3. Flood-Frequency Estimation
   Computes T-year floods using:
       - GEV
       - GNO
       - PE3
       - LN3
       - GUM

4.  Distribution Comparison Table
   Generates an extended table for multiple return periods:
       2.3, 5, 10, 15, 20, 50, 100, 200, 500, 1000

5.  Converts results into wide format and formats using gt.


6.  Optional Histogram + Normal Fit
   - Histogram of flood data
   - Overlaid normal distribution curve


## Features

### Data Input & Visualization
- Reads flood data from a text file (Year + Annual Maximum Discharge)
- Produces a bar plot of annual maximum flood values
- Displays basic data structure using R data frames

---

### L-Moment Computation
- Computes sample L-moments using:
  ```R
  lmom <- lmoms(data$Qmaks)
  
# OUTPUTS:

- Return-period flood values printed to console
- Bar plot of annual maximum discharges
- GT-formatted table of multi-distribution results
- Optional histogram + normal fit curve
