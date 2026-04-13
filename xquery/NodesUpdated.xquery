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
  let $subjects := $countrySongs/@subject/string()
  let $distinctSubjects := distinct-values($subjects)
  order by $country
  return (
    concat($country, ",country,", count($countrySongs), $linefeed),
    for $subject in $distinctSubjects
      let $count := count($countrySongs[@subject = $subject])
      let $subjectName := $subject !replace(., "lv", "Love") !replace(., "lg", "Legend") !replace(., "ss", "Superstition") !replace(., "dt", "Death") !replace(., "bt", "Battle") !replace(., "dk", "Drinking") !replace(., "wk", "Work") !replace(., "dp", "Departure") !replace(., "hs", "Homesickness") !replace(., "sl", "Sea Life")
      return concat($subjectName, ",subject,", $count, $linefeed)
  )
))
