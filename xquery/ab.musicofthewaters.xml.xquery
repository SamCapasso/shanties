(:let $allSongs := //songTitle[@originLocation]
let $locations := $allSongs/data(@originLocation) => distinct-values()
for $loc in $locations
let $songCount := //songTitle[data(@originLocation) = $loc] => count()
where $songCount > 1
order by $songCount descending
return concat("&#xa;", $loc, " has ", $songCount, " songs in the collection.") :)

(:let $allSongs := //songTitle[@originLocation]
let $locations := $allSongs/data(@originLocation) => distinct-values()
for $loc in $locations
let $locSongs := //songTitle[data(@originLocation) = $loc]/data(@str)
where count($locSongs) > 1
order by $loc ascending
return concat("&#xa;", $loc, ": ", string-join($locSongs, " | ")) :)

(:let $allSongs := //songTitle[@subject]
let $subjects := $allSongs/data(@subject) => distinct-values()
for $subj in $subjects
let $subjCount := //songTitle[data(@subject) = $subj] => count()
order by $subjCount descending
return concat("&#xa;", $subj, " -- ", $subjCount, " songs") :)

