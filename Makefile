SHELL:=/usr/bin/env bash

LOG_INFO=$(shell date +"%H:%M:%S") \e[0;34mINFO\e[0m
LOG_ERROR=$(shell date +"%H:%M:%S") \e[1;31mERROR\e[0m
LOG_WARNING=$(shell date +"%H:%M:%S") \e[0;33mWARNING\e[0m
LOG_SUCCESS=$(shell date +"%H:%M:%S") \e[0;32mSUCCESS\e[0m
GIT_ROOT=$(shell git rev-parse --show-toplevel)

.DEFAULT_GOAL := load

load:
	@echo -e "$(LOG_INFO) Loading dev env..."
	@echo -e "$(LOG_WARNING) Opening $(GIT_ROOT)"
	nvim --cmd "set rtp+=$(GIT_ROOT)"
