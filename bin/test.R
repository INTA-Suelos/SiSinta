#!/usr/bin/env Rscript

args <- commandArgs(TRUE)
png(filename=as.character(args[2]))
plot(as.numeric(args[1]))
dev.off()
