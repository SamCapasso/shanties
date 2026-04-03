declare option saxon:output "method = html";

declare variable $sections := doc("../xml/MusicOfTheWaters");
declare variable $songTitles := $sections//songTitle;
declare variable $originLocations := $sections//songTitle/@originLocation/data()=>distinct-values();
declare variable $subjects := $sections//songTitle/@subject/data()=>distinct-values();

<html>
    <head>
        <title>Subject by Country/Region</title>
    </head>
    
    <body>
        <h1>Cubject by Country/Region</h1>
        <p>This displays the breakdown of the percentages of shanties of each subject in each country/region.</p>
        <p>Subject key:</p>
        <ul>
            <li>sl = sea life</li>
            <li>hs = homesickness</li>
            <li>dp = departure</li>
            <li>wk = work</li>
            <li>dk = drinking</li>
            <li>bt = battle</li>
            <li>dt = death</li>
            <li>ss = superstition</li>
            <li>lg = legend</li>
            <li>lv = love</li>
        </ul>
        <p>Alphabetized, tiered list:</p>
        <ul>{for $originLocation in $originLocations
            order by $originLocation
            return <li>{$originLocation}<ul>{
                for $subject in $subjects
                    let $subjectNumber := $songTitles[./@originLocation = $originLocation][./@subject = $subject]=>count()
                    where $subjectNumber > 0
                    order by $subject
                    return <li>{$subject}: {$subjectNumber}</li>}</ul></li>
        }</ul>
    </body>
</html>
