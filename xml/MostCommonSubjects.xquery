xquery version "3.1";

declare namespace functx = "http://www.functx.com";

(: Get all songTitle elements with originLocation and subject :)
let $songs := //songTitle[@originLocation and @subject]

(: Group by country :)
let $countries := distinct-values($songs/@originLocation)

for $country in $countries
  let $countrySongs := $songs[@originLocation = $country]
  let $subjects := $countrySongs/@subject/string()
  let $distinctSubjects := distinct-values($subjects)
  
  (: Count occurrences of each subject :)
  let $subjectCounts :=
    for $subject in $distinctSubjects
    let $count := count($countrySongs[@subject = $subject])
    order by $count descending
    return <subjectCount subject="{$subject}" count="{$count}"/>
  
  (: Take the top subject :)
  let $topSubject := $subjectCounts[1]

order by $country
return
  <country name="{$country}"
           topSubject="{$topSubject/@subject}"
           count="{$topSubject/@count}"
           totalSongs="{count($countrySongs)}"/>