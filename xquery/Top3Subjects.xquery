xquery version "3.1";
declare namespace functx = "http://www.functx.com";
let $songs := //songTitle[@originLocation and @subject]
let $countries := distinct-values($songs/@originLocation)
for $country in $countries
  let $countrySongs := $songs[@originLocation = $country]
  let $subjects := $countrySongs/@subject/string()
  let $distinctSubjects := distinct-values($subjects)

  where count($distinctSubjects) >= 3

  let $subjectCounts :=
    for $subject in $distinctSubjects
    let $count := count($countrySongs[@subject = $subject])
    order by $count descending
    return <subjectCount subject="{$subject}" count="{$count}"/>

order by $country
return
  <country name="{$country}"
           totalSongs="{count($countrySongs)}"
           distinctSubjects="{count($distinctSubjects)}">
    {$subjectCounts[position() <= 3]}
  </country>