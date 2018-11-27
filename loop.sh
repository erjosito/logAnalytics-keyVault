#!/bin/bash
while true
do
    # Create 20 secrets
	./akv.sh -c 20
    # Read 30 secrets (the last 10 will generate errors)
	./akv.sh -r 30
    # Delete the created 20 secrets
    ./akv.sh -d 20 
done