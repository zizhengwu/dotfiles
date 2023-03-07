#!/bin/bash
# Used by p4/Perforce $P4MERGE environment variable to use Beyond Compare (www.scootersoftware.com) for merging.
/usr/local/bin/bcompare $2 $3 $1 $4
