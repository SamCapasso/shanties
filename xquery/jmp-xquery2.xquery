xquery version "3.1";


for $song in /book/content/section/songTitle        (: FOR: every song entry :)

let $lyrics := $song/following-sibling::lyrics[1]   (: LET: bind the first lyrics block that follows each title :)

where contains(lower-case($lyrics), "love")         (: WHERE: keep only songs whose lyrics mention love... :)
   or contains(lower-case($lyrics), "farewell")
   or contains(lower-case($lyrics), "part")         (:        ...or farewell / parting / homesickness themes :)
   or contains(lower-case($lyrics), "home")
   or contains(lower-case($lyrics), "grief")
   or contains(lower-case($lyrics), "sad")
   or $song/@subject = "hs"                         (:        ...or are already tagged as homesickness (hs) :)
   or $song/@subject = "dp"                         (:        ...or as departure (dp) :)

order by $song/ancestor::section/@id ascending,     (: ORDER BY: section first, then song title alphabetically :)
         $song/@str ascending

return                                               (: RETURN: structured summary of each matching song :)
  <match>
    <section>{ string($song/ancestor::section/heading) }</section>
    <title>{ string($song/@str) }</title>
    <origin>{ string($song/@originLocation) }</origin>
    <subject_code>{ string($song/@subject) }</subject_code>
    <lyric_excerpt>{ substring(normalize-space($lyrics), 1, 120) }…</lyric_excerpt>
  </match>