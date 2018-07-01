#!/bin/sh

# most is a better pager as it provides styling (e.g. run 'man ls' with most set as your pager)
brew install most

echo "Add this stuff to your .bashrc" 
echo export PAGER=most
