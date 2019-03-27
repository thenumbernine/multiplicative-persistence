#!/bin/sh
./run.lua graph | tee g.graph
dot -Tsvg g.graph > g.svg
