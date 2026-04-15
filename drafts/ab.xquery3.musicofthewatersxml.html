(:declare option saxon:output "omit-xml-declaration=yes";
let $allSongs := //songTitle[@originLocation]
let $locations := $allSongs/data(@originLocation) => distinct-values()
for $loc in $locations
let $songCount := //songTitle[data(@originLocation) = $loc] => count()
where $songCount > 1
order by $songCount descending
return concat("&#xa;", $loc, " has ", $songCount, " songs in the collection."):)

(:let $allSongs := //songTitle[@originLocation]
let $locations := $allSongs/data(@originLocation) => distinct-values()
for $loc in $locations
let $locSongs := //songTitle[data(@originLocation) = $loc]/data(@str)
where count($locSongs) > 1
order by $loc ascending
return concat("&#xa;", $loc, ": ", string-join($locSongs, " | ")):)

(:let $allSongs := //songTitle[@subject]
let $subjects := $allSongs/data(@subject) => distinct-values()
for $subj in $subjects
let $subjCount := //songTitle[data(@subject) = $subj] => count()
order by $subjCount descending
return concat("&#xa;", $subj, " -- ", $subjCount, " songs") :)

declare option saxon:output "method=html";

declare variable $allSongs := //songTitle[@originLocation];
declare variable $locations := $allSongs/data(@originLocation) => distinct-values();

<html>
    <head>
        <title>Music of the Waters: Songs by Country</title>
    </head>
    <body>
        <h1>Music of the Waters (1888)</h1>
        <h2>Number of Songs per Country or Region</h2>
        <p>If you've ever wondered the amount of sea shanties that have
        come from any certain country, this is the place to be!</p>
        <table>
            <tr>
                <th>Ranking</th>
                <th>Country/Region</th>
                <th>Number of Songs</th>
            </tr>
            {
                for $loc at $pos in $locations
                let $songCount := $allSongs[data(@originLocation) = $loc] => count()
                where $songCount > 1
                order by $songCount descending
                return
                    <tr>
                        <td>{$pos}</td>
                        <td>{$loc}</td>
                        <td><b>{$songCount}</b></td>
                    </tr>
            }
        </table>
    </body>
</html>