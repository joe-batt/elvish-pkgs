use str

var -seed-cmd
var -start-cmd
var -start-key
var -select-key

fn completion-start {
  set @-seed-cmd = (str:split " " $edit:current-command)
  $-start-cmd
}

fn completion-multi-select {
  edit:listing:accept
  if (str:has-suffix $edit:current-command /) {
    set edit:current-command = $edit:current-command" "
  }
  set edit:current-command = $edit:current-command$-seed-cmd[-1]
  $-start-cmd
}

fn init {|&select-key=Ctrl+E &start-key=Tab &start-cmd=$edit:completion:smart-start~|
  set -start-cmd = $start-cmd
  set edit:insert:binding[$start-key] = $completion-start~
  set edit:completion:binding[$select-key] = $completion-multi-select~
}
