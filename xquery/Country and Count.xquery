declare option saxon:output "method=text";

declare variable $sections := doc("../xml/MusicOfTheWaters.xml");
declare variable $songTitles := $sections//songTitle;
declare variable $originLocations := $sections//songTitle/@originLocation/data()=>distinct-values();

for $originLocation in $originLocations
    let $shantyCount := $songTitles[./@originLocation = $originLocation]=>count()
    order by $originLocation
    return concat($originLocation, ",", $shantyCount, "&#xA;")