#!/usr/bin/python

# Copyright 2015, Opalytics, Inc.

# edited with permission from Gurobi Optimization, Inc.

# Separate the model (dietmodel.py) from the data file (dietxlsdata.py), so
# that the model can be solved with different data files.
#
# This file solves the model with the data provided by the Excel file "diet.xls".
# It prints the summary information to the screen, and write the solution into a
# a "solution.xls" file, overwriting any pre-existing "solution.xls" file.
#

from dietmodel import solve, dataFactory, solutionFactory
import os

# read the data from diet.xls into the FrozenTicDat object dat
dat = dataFactory.xls.create_frozen_tic_dat("diet.xls")

solution =  solve(dat)

if solution :
    print('\nCost: %g' % solution.parameters[0]["totalCost"])
    # will write to a solution subdirectory, overwriting any pre-existing solution
    solutionFactory.xls.write_file(solution, "solution.xls", allow_overwrite=True)
else :
    print('\nNo solution')

