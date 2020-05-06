#!/bin/bash -l

awk 'FNR>1' contam_report_bac/*.csv > contam_bac.csv
awk 'FNR>1' contam_report/*.csv > contam.csv
