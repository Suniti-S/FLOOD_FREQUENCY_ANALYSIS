# Flood Frequency Analysis in R Using L-Moments (lmomco Package)

This repository contains an R script for performing **flood-frequency analysis** using annual maximum discharge values. The workflow includes reading hydrological data, computing L-moments, fitting probability distributions, estimating return-period floods, and generating formatted result tables.

The method is based on the **lmomco** package by W.H. Asquith, which uses L-moments to fit distributions commonly used in hydrology.

---

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
