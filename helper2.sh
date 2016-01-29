#!/bin/bash
numberoflines=453
while read -r line
  do
     curl -s "" >> Level2HTML
     echo "We need to process more  lines"
     ((numberoflines--))
  done < xab
