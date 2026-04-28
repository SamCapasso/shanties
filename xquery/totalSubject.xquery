let $doc   := doc("MusicOfTheWaters.xml")
let $songs := $doc//songTitle[@subject]
let $codes := distinct-values(($songs/@subject/string(), $songs/@subject2/string()))

let $subject-labels := map {
  "sl": "Sea Life",      "hs": "Homesickness",
  "dp": "Departure",     "wk": "Work",
  "dk": "Drinking",      "bt": "Battle",
  "dt": "Death",         "ss": "Superstition",
  "lg": "Legend",        "lv": "Love / Longing"
}

let $data :=
  for $code in $codes
  let $c := count($songs[@subject = $code]) + count($songs[@subject2 = $code])
  let $label := ($subject-labels($code), $code)[1]
  order by $c descending
  return map { "label": $label, "count": $c }

let $bar-h   := 22
let $gap     := 7
let $label-w := 200
let $chart-w := 400
let $r-pad   := 55
let $n       := count($data)
let $max     := max(for $e in $data return $e?count)
let $svg-w   := $label-w + $chart-w + $r-pad
let $svg-h   := $n * ($bar-h + $gap)

return
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <title>Music of the Waters – Songs by Subject</title>
    <style>
      body {{
        font-family: Arial, sans-serif;
        background-color: #f4f4f4;
        padding: 40px 20px;
      }}
      h1 {{
        font-size: 22px;
        color: #1a3d5c;
        margin-bottom: 6px;
      }}
      p.subtitle {{
        font-size: 13px;
        color: #666;
        margin-bottom: 30px;
      }}
    </style>
  </head>
  <body>
    <h1>Music of the Waters</h1>
    <p class="subtitle">Number of songs by subject, sorted by frequency</p>
    <div class="chart-box">
      <svg xmlns="http://www.w3.org/2000/svg"
           width="{$svg-w}" height="{$svg-h}"
           font-family="Arial, sans-serif">
        {
          for $entry at $pos in $data
          let $y     := ($pos - 1) * ($bar-h + $gap)
          let $bar-w := xs:integer(($entry?count div $max) * $chart-w)
          return (
            <text x="{$label-w - 8}" y="{$y + 15}"
                  text-anchor="end" font-size="11" fill="#333">{$entry?label}</text>,
            <rect x="{$label-w}" y="{$y}" width="{$bar-w}" height="{$bar-h}"
                  fill="#2c6fad"/>,
            <text x="{$label-w + $bar-w + 6}" y="{$y + 15}"
                  font-size="11" font-weight="bold" fill="#2c6fad">{$entry?count}</text>
          )
        }
      </svg>
    </div>
  </body>
</html>