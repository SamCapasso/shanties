(: This XQuery counts how many times each subject appears
  in the main XML document "MusicOfTheWaters.xml". :)

(: Step 1: Select all distinct subject values :)
for $subj in distinct-values(doc("MusicOfTheWaters.xml")//songTitle/@subject)

(: Step 2: Store all songTitle elements that match the current subject
  I used let to create a reusable variable so the same query doesnt repeat. :)
let $songs := doc("MusicOfTheWaters.xml")//songTitle[@subject = $subj]

(: Step 3: Filter out any empty or missing subject values
  I used where make sure we dont count any times where a subject is not mentioned. :)
where string-length($subj) > 0

(: Step 4: Sort the results by the number of occurrences (descending)
  so that the more common subjects show up first. :)
order by count($songs) descending

(: Step 5: result
  I believe this will output each subject along with how many times it appears. :)
return
  <subjectCount>
    <subject>{ $subj }</subject>
    <count>{ count($songs) }</count>
  </subjectCount>
  
  (:Note I am having trouble running and testing this because our xml has structural errors still. I THINK this should work but I do not know that. :)