#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created 08/01/2026
Last updated 08/01/2026

@author: Jack Cavanagh (jcavanagh@povertyactionlab.org)

Purpose: This is the main orchestrator script for the RST 2026 Data Coding Best Practices Exercise.
It will be used to validate and clean the data from the three pulls.
"""

import random

from config import NUM_PULLS, DATA_DIR, SEED ### Anything else?

print(f"Number of pulls: {NUM_PULLS}")
print(f"Data directory: {DATA_DIR}")
print(f"Raw data directory: ")
print(f"De-identified data directory: ")
print(f"Clean data directory: ")

random.seed(SEED)