# Test suite with roundup
# See https://github.com/bmizerany/roundup

describe "testing the tasker"

tasker='./tasker.sh'

before() {
    $tasker --clear
}

it_can_add_a_task() {
    $tasker --add "one of my tasks"
    test $($tasker --list | wc -l) -eq 1
}

it_can_add_multiple_tasks() {
    $tasker --add "one of my tasks"
    $tasker --add "a second task"
    test $($tasker --list | wc -l) -eq 2
}

it_can_display_tasks() {
    $tasker --add "one of my tasks"
    $tasker --add "a second task"
    test "$($tasker --list | head -1 | grep -c 'one of my tasks')" -eq 1
    test "$($tasker --list | tail -1 | grep -c 'a second task')" -eq 1
}
