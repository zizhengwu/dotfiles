#!/bin/bash

declare -i left=0
declare -i right=0

if [ $# -eq 2 ]
# G4MULTIDIFF must have been unset or empty and hence Piper is calling us with one file comparison at a time.
then 
    # Call BeyondCompare. Note that "-leftreadonly" option makes left side (depot version) of the comparison read-only. Replace this with -readonly to make both sides readonly, etc as appropriate. See http://www.scootersoftware.com/help/index.html?command_line_reference.html.
    /use/local/bin/bcompare -leftreadonly $1 $2 & 
else
    # G4MULTIDIFF is set to a non-empty value and piper calls $P4DIFF with all pairs separated by ":". E.g. : /tmp/cache/file1#61 /home/me/file1 : /tmp/cache/file2#18 /home/me/file2 : /tmp/cache/file3#52 /home/me/file3. See http://wiki/Main/G4Recipes.
    for (( c=2; c<$#; c=c+3 ))
    do # Open all file diffs in this changelist as multiple tabs in the same BC window.
      left=$c
      right=$((c+1))
      /use/local/bin/bcompare -leftreadonly ${!left} ${!right} &
    done
fi
