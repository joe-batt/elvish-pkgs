fn split-words {|str|
  var single_quote = $false
    var double_quote = $false
    var tmpstr = ''
    var len = (count $str)
    range (count $str) | each {|i|
      var c = $str[$i]
        if (and (eq $c '"') (not $single_quote)) {
          set double_quote = (not $double_quote)
        }
      if (and (eq $c "'") (not $double_quote)) {
        set single_quote = (not $single_quote)
      }
      if (and (eq $c " ") (not (or $double_quote $single_quote))) {
        put $tmpstr
          set tmpstr = ''
      } else {
        set tmpstr = $tmpstr$c
      }
    }
  put $tmpstr
}

fn word-at-dot {|dot @words|
  var pos = 0
  for w $words {
    set pos = (+ $pos (count $w) 1)
    if (>= $pos $dot) {
      if (eq $w $words[-1]) {
        put $w (- $pos 2)
      } else {
        put $w (- $pos 1)
      }
      return
    } 
  } 
}
