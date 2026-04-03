(:xquery version "3.1";


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
  </match>:)
  
  
declare option saxon:output "method=html";

declare variable $sect-1 := doc('../xml/Section_1_Markup.xml');
declare variable $sect-2 := doc('../xml/Markup2Unified.xml');
declare variable $sect-3 := doc('../xml/gp-section3.xml');
declare variable $sect-4 := doc('../xml/shanties.markup.section.4.xml');

declare variable $sections := ($sect-1 | $sect-2 | $sect-3 | $sect-4);

(: Build a scored sequence of maps from all matching songs across all sections :)
declare variable $sorted :=
  let $matches :=
    for $song in $sections/book/section/songTitle
    let $lyrics    := $song/following-sibling::lyrics[1]
    let $lyricsLC  := lower-case($lyrics)
    let $subject   := $song/@subject

    (: Score: count how many signals are present :)
    let $score :=
        (if (contains($lyricsLC, "love"))    then 2 else 0) +
        (if (contains($lyricsLC, "farewell")) then 1 else 0) +
        (if (contains($lyricsLC, "part"))    then 1 else 0) +
        (if (contains($lyricsLC, "home"))    then 1 else 0) +
        (if (contains($lyricsLC, "grief"))   then 2 else 0) +
        (if (contains($lyricsLC, "sad"))     then 2 else 0) +
        (if ($subject = "hs")               then 3 else 0) +
        (if ($subject = "dp")               then 3 else 0)

    where $score gt 0   (: only keep songs that matched at least one signal :)

    let $sectionNum := $song/ancestor::section/@n
    let $excerpt    := substring($lyrics, 1, 120)

    return map {
      "score"     : $score,
      "section"   : string($sectionNum),
      "songTitle" : string($song),
      "elemType"  : local-name($song),
      "display"   : $excerpt
    }

  (: Sort descending by score :)
  for $m in $matches
  order by $m("score") descending
  return $m;

<html>
  <head>
    <title>Love and Sadness in <em>Music of the Waters</em></title>
  </head>
  <body>
    <h1>Love and Sadness Mentions</h1>
    <p>Sailors would often sing about lost loves and home while out on the open
       ocean. This is a breakdown of every time these are mentioned in
       <em>Music of the Waters</em>.</p>

    <table>
      <thead>
        <tr>
          <th>#</th>
          <th>Score</th>
          <th>Section</th>
          <th>Song Title</th>
          <th>Element Type</th>
          <th>Excerpt</th>
        </tr>
      </thead>
      <tbody>
        {
          for $item at $pos in $sorted
          return
            <tr>
              <td>{$pos}</td>
              <td class="score">{$item("score")}</td>
              <td>{$item("section")}</td>
              <td>{$item("songTitle")}</td>
              <td>{$item("elemType")}</td>
              <td class="excerpt">{$item("display")}&#x2026;</td>
            </tr>
        }
      </tbody>
    </table>
  </body>
</html>