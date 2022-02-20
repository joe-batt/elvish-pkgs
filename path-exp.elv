# 
# path expansion in elvish shell completion
# (c) Johannes Battenberg 2022
#
# for license see LICENSE
#
# install via epm:
#   use epm
#   epm:install github.com/joe-batt/elvish-pkgs
#
# This module requires zzamboni's elvish-completions install it via
#   use:epm 
#   epm:install github.com/zzamboni/elvish-completions
#
# afterwards import with and initialize
#   use github.com/joe-batt/elvish-pkgs/path-exp
#   multi-select:init
# 
# init takes several optional arguments
# &use-cd: Set to $false to disable path expansion for cd completion
# &use-default: set to $false to disable path expansion for default completion
use github.com/zzamboni/elvish-completions/comp
use str
use path

fn -expand-dirs {|stem &dirs-only=$false|
    # make sure there are no variables or commands in the current stem
    # so nothing bad happens during eval
    if (not (str:contains-any $stem '$()*')) {

      # insert wildcards so e.g. /u/share becomes /u*/share
      # and make sure spaces are escaped
      set stem = (str:trim-prefix (str:replace '/' '*/' $stem) "*")
      if (str:contains $stem ' ') {
        set stem = (str:replace ' ' "' '" $stem)
      }
      eval 'put '$stem | each {|cand|
        comp:files $cand &dirs-only=$dirs-only
      }
    }
}

fn -expand-completion {|stem &dirs-only=$false|
  var dir = (path:dir $stem)

  # use standard completion if the directory exists, otherwise
  # try to expand
  if (path:is-dir $dir) {
    comp:files $stem &dirs-only=$dirs-only
  } else {
    -expand-dirs $dir/ &dirs-only=$dirs-only
  }
}

fn init {|&use-cd=$true &use-default=$true|
  if $use-default {
    set edit:completion:arg-completer[''] = {|@args| -expand-completion $args[-1]}
  }
  if $use-cd {
    set edit:completion:arg-completer['cd'] = {|@args| -expand-completion $args[-1] &dirs-only=$true}
  
  }
}
