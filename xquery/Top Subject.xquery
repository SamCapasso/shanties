declare option saxon:output "method=text";

declare variable $sections := doc("../xml/MusicOfTheWaters.xml");
declare variable $songTitles := $sections//songTitle;
declare variable $originLocations := $sections//songTitle/@originLocation/data()=>distinct-values();
declare variable $subjects := $sections//songTitle/@subject/data()=>distinct-values();

for $originLocation in $originLocations
    let $shanties := $songTitles[./@originLocation = $originLocation]
    let $subjectCounts :=
        for $subject in $subjects
            let $count := $shanties[./@subject = $subject]=>count()
            order by $count descending
            return <subjectCount subject="{$subject}" count="{$count}"/>
    let $topSubject := $subjectCounts[1]
    order by $originLocation
    return concat($originLocation, ",", $topSubject/@subject, "&#xA;")