#!/bin/bash
# Provides some general-purpose script functions

RED=$(tput setaf 1)
NORMAL=$(tput op)

die() {
	echo -e "${RED}$1${NORMAL}"
	exit 1
}

check_commands() {
	for i in $*; do
		command -v $i >/dev/null || { die "Required command $i not found"; exit 1; }
	done
}

mkfiles() {
    [ $# -eq 2 ] || die "! Usage: $0 {range} {extension}"
    range=$1
    ext=$2
    if ! [[ $1 =~ ^[0-9]+\.\.[0-9]+ ]];
        then die "! Usage: $0 {range}" >&2; exit 1
    fi
    for i in $(eval echo "{$range}"); do touch file$i.$ext; done
}

mkdirs() {
    [ $# -eq 1 ] || die "! Usage: $0 {range}"
    range=$1
    if ! [[ $1 =~ ^[0-9]+\.\.[0-9]+ ]];
        then die "! Usage: $0 {range}" >&2; exit 1
    fi
    for i in $(eval echo "{$range}"); do mkdir -p folder$i; done
}