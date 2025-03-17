#!/bin/bash

eval set -- $(getopt -o i:h -n "$0" -- "$@")

function die() {
  echo >&2 "$*"
  exit 1
}

function show_help() {
  echo "-i: image_name"
}

while true; do
  case "$1" in
    -i) image_name="$2"; shift 2 ;;
    -h) show_help;         exit    ;;
    --) shift; break               ;;
    *)  die "Invalid arg $1"       ;;
  esac
done

export PS4='+ ${BASH_SOURCE}:${LINENO}${FUNCNAME[0]:+ [${FUNCNAME[0]}(${#FUNCNAME[@]})]}> '
set -ex

function main() {
  gsutil cp gs://gmec-cos-test-builds/${image_name}.tar.gz ~/Downloads 
  scp -r ~/Downloads/${image_name}.tar.gz ubuntu@10.251.209.8:/home/ubuntu/zizhengwu
  ssh ubuntu@10.251.209.8 "cd /home/ubuntu/zizhengwu/ && tar -xzvf ${image_name}.tar.gz"
  ssh ubuntu@10.251.209.8 "mv /home/ubuntu/zizhengwu/disk.raw /home/ubuntu/zizhengwu/${image_name}.raw"
}

main "$@"
