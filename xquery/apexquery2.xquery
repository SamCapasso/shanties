declare option saxon:output "omit-xml-declaration = yes";
(: Removes the xml declaration :)
let $songList := //songTitle
(: Turns the song titles into a variable :)
for $song in $songList
(: Separates the songs and works on them individually :)
    let $location := //$song/@originLocation
    (: Turns each individual origin location into a variable :)
    where $location = "England"
    (: Filters the origin locations to only be from England :)
order by $song/@str
(: Sorts titles alphabetically :)
return concat($song/@str, "&#xa;")
(: Outputs each value followed by a newline character :)

(: Side note: I don't know why each line after the first
has a space in front of it.  I couldn't figure it out. :)