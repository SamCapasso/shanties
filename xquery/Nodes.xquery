xquery version "3.1";
declare namespace functx = "http://www.functx.com";
declare option saxon:output "method=text";
declare variable $linefeed := "&#10;";
concat("label,Type,Count" ,$linefeed, 
string-join(
let $songs := //songTitle[@originLocation and @subject]
let $countries := distinct-values($songs/@originLocation)
for $country in $countries
  let $countrySongs := $songs[@originLocation = $country]
 
  
  (:where count($distinctSubjects) >= 3:)
 (: let $subjectCounts :=
    for $subject in $distinctSubjects
    let $count := count($countrySongs[@subject = $subject])
    order by $count descending
    return <subjectCount subject="{$subject}" count="{$count}"/>
  let $top3 := $subjectCounts[position() <= 3]:)
  let $countryCount := count($countrySongs)
order by $country
return
  concat(
    $country,
    ",country,", count($countrySongs), $linefeed)
    
    let $subjects := $countrySongs/@subject/string()
  let $distinctSubjects := distinct-values($subjects)
   for $subject in $distinctSubjects
    let $count := count($countrySongs[@subject = $subject])
  
  ))
  
