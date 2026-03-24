declare option saxon:output "method = html";

declare variable $sections := collection("parent::shanties/xml/?select = Section\ 1\ Markup.xml, Markup2Unified.xml, gp-section3.xml, shanties.markup.section.4.xml");
declare variable $originLocations := $sections//songTitle/@originLocation;
declare variable $subjects := $sections//songTitle/@subject;

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
        <p>Alphebetized, tiered list:</p>
        <ul>{for $originLocation in $originLocations
            order by $originLocation
            return <li>{$originLocation}<ul><li>{
                for $subject in $subjects
                    let $subjectNumber := $subjects=>count()
                    where $sections/songTitle/@originLocation = $originLocation
                    order by $subject
                    return concat($subject, ": ", $subjectNumber)}</li></ul></li>
        }</ul>
    </body>
</html>