#! /usr/bin/env bash

function main() {
  usage="usage: random_int_array <lo-hi>, not that <lo-hi> is inclusive"

  if [[ -z "$1" ]]
  then
    echo "$usage"
    return -1
  fi

  # range
  range=$1

  # count
  count=10

  for ((i=0; i < $count; i++))
  do
    echo -n "["
    length=$(shuf -i 1-10 -n 1)
    for ((j=0; j < $length; j++))
    do
      echo -n $(shuf -i $range -n 1)
      if [[ $j != $(($length - 1)) ]]
      then
        echo -n ", "
      fi
    done
    echo "]"
  done
}

main $@
