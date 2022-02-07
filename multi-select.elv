# 
# multi select in elvish shell completion
# (c) Johannes Battenberg 2022
#
# for license see LICENSE
#
# install via epm:
#   epm:install github.com/joe-batt/elvish-pkgs
#
# afterwards import with and initialize
#   use github.com/joe-batt/elvish-pkgs/multi-select
#   multi-select:init
# 
# init takes several optional arguments
# &start-cmd: The command to start completion, default edit:completion:smart-start
# &select-key: key to select entry without ending completion, default Ctrl+e
# &start-key: key to start completion. default Tab

use str

var -seed-cmd
var -start-cmd

# store the current command in -seed-cmd and start completion
fn completion-start {
  set @-seed-cmd = (str:split " " $edit:current-command)
  $-start-cmd
}

# select current entry from listing and restart completion with the last
# element of the stored command in -seed-cmd
fn completion-multi-select {
  edit:listing:accept
  if (str:has-suffix $edit:current-command /) {
    set edit:current-command = $edit:current-command" "
  }
  set edit:current-command = $edit:current-command$-seed-cmd[-1]
  $-start-cmd
}

# setup key bindings and store preferred completion command
fn init {|&select-key=Ctrl+E &start-key=Tab &start-cmd=$edit:completion:smart-start~|
  set -start-cmd = $start-cmd
  set edit:insert:binding[$start-key] = $completion-start~
  set edit:completion:binding[$select-key] = $completion-multi-select~
}
