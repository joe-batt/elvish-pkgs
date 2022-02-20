# elvish-pkgs

A set of personal .elv files

## Usage

Install using [epm](https://elvish.io/ref/epm.html):
```
use epm 
epm:install github.com/joe-batt/elvish-pkgs
```

Afterwards you can load the individual modules in your `rc.elv`:
```
use github.com/joe-batt/elvish-pkgs/<module>
```

## Modules

### multi-select

This module allows selecting multiple entries from a completion selection list;
a feature I was missing coming from `zsh`. 
In the suggestion listing you press a key combination (default `Ctrl+e`) it will
insert the selected value but restart the completion process with the same stem.

If you have a directory `/path/to/my/dir` containing – among others – the files
`foo` and `bar` that you want to copy you would type
```
cp /path/to/my/dir/<Tab>
```
then select `foo` with `Ctrl+e`, you will see
```
cp /path/to/my/dir/foo /path/to/my/dir/<somefile>
```

with the selection list open.

To use put this in your `rc.elv`
```
use github.com/joe-batt/elvish-pkgs/multi-select
mulit-select:init
```

This will setup the complete key to `Tab`, the multi select key to `Ctrl+e` and
the completion start command to `edit:completion:smart-start`. The start command is
needed because this module needs to store the original completion stem on starting
the completion and therefore using a wrapper function. You can change of all these
by passing parameters `start-key`, `select-key` and/or `start-cmd` to `init`, e.g.:
```
multi-select:init &start-key=Alt-L &select-key=Alt-F &start-cmd=$edit:completion:start~
```

### path-exp
This module provides expansion for paths in completions, eg. `/u/share` will
expand to `/usr/share`. The expansion is only executed if the base directory
does not exist. So if you have two directories `/path/to/dir` and `/path/to/dir2` 
calling
```
cd /path/to/dir/<TAB>
```
will not show completions to `dir2`.

This module requires zzamboni's elvish-completions package, install it via
```
use epm
epm:install github.com/zzamboni/elvish-completions
```

To use `path-exp` put this in your `rc.elv`
```
use github.com/joe-batt/elvish-pkgs/path-exp
path-exp:init
```

This will setup the path expansion for `cd` completion as well as for default
completion. You can disable these by passing the options `&use-cd=$false` or 
`&use-default=$false` to init, e.g
```
path-exp:init &use-cd=$false
```
