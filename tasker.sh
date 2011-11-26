#!/usr/bin/env bash

completed_file='completed.txt'
outstanding_file='outstanding.txt'

function add-task {
    task="$1"
    echo "$task" >> $outstanding_file
    echo "Task added: '$task'"
}

function complete-task {
    num="$1"

    # add task to completed file
    sed -n "${num}p" $outstanding_file >> $completed_file

    # task is no longer oustanding
    sed -i -e "${num}d" $outstanding_file
}

while [ $# -ne 0 ]; do
    if [ $1 == '--add' ]; then
        [ -z "$2" ] && echo "need a text argument" && exit
        add-task "$2"
        shift 2
    elif [ $1 == "--list" ]; then
        cat -n $outstanding_file
        shift
    elif [ $1 == "--complete" ]; then
        [ -z "$2" ] && echo "please supply the task number" && exit
        complete-task "$2"
        shift 2
    elif [ $1 == "--completed" ]; then
        cat -n $completed_file
        shift
    fi
done

