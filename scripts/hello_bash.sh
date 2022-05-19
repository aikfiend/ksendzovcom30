#!/bin/bash

case "$(uname -s)" in
    Linux*)
        cmd='readlink -f'
        ;;
    Darwin*)
        command -v greadlink >/dev/null || ( echo "Command greadlink not found, try: brew install coreutils"; exit 1 )
        cmd='greadlink -f'
        ;;
esac

DIR=$(dirname `$cmd -f $0`)
. $DIR/functions.sh

URL='http://162.55.220.72:5005'
name='John%20Snow'
age=30

[ $# -eq 1 ] || die "! Usage: $0 {path}"

mkdir -p $1 2>/dev/null || die "! Check write permissions for path specified: $1"

cd $1 && mkdirs 1..3

[ -d folder2 ] && cd folder2 || die "No such directory folder2"

mkfiles 1..3 txt && mkfiles 1..2 json

echo -e "\nCurrent directory `pwd` listing:" && ls -la

[ -d ../folder3 ] && [ -f file1.txt ] && [ -f file2.txt ] && mv file1.txt file2.txt ../folder3

echo  -e "\nServer response:" && check_commands curl && curl -sS "$URL/get_method?name=$name&age=$age"