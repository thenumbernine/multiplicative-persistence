#!/bin/sh
./run.lua graph > g.graph
dot -Tsvg g.graph > g.svg
