(: This query counts the number of songs for each language based on the @str attribute in <lyrics> elements, and outputs the results as an HTML table. :)
(: this sort of works, however we all have the str attribute under lyrics used differently so it only really works for some of our sections. This could still be helpful later with some tweaks:)

(: Step 1: Select all lyrics elements :)
let $lyrics := //lyrics

(: Step 2: Extract all distinct language values :)
let $languages := distinct-values($lyrics/@str)

(: Step 3: Construct HTML output :)
return
<html>
  <head>
    <title>Song Count by Language</title>
  </head>
  <body>
    <h2>Number of Songs per Language</h2>
    <table border="1">
      <tr>
        <th>Language</th>
        <th>Number of Songs</th>
      </tr>
      {
        (: Step 4: Loop through each language :)
        for $lang in $languages

        (: Step 5: Count how many lyrics elements use that language :)
        let $count := count($lyrics[@str = $lang])

        (: Step 6: Sort results alphabetically by language :)
        order by $lang

        (: Step 7: Output each row in the table :)
        return
          <tr>
            <td>{ $lang }</td>
            <td>{ $count }</td>
          </tr>
      }
    </table>
  </body>
</html>