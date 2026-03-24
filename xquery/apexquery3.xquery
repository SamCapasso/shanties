declare option saxon:output "method = html";

declare variable $section1 := doc("../xml/Section 1 Markup.xml");
declare variable $section2 := doc("../xml/Markup2Unified.xml");
declare variable $section3 := doc("../xml/gp-section3.xml");
declare variable $section4 := doc("../xml/shanties.markup.section.4.xml");
declare variable $sections := ($section1 | $section2 | $section3 | $section4);

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
            return <li>{$originLocation}<ul><li>{
                for $subject in $subjects
                    let $subjectNumber := $subjects=>count()
                    where $sections/songTitle/@originLocation = $originLocation
                    order by $subject
                    return concat($subject, ": ", $subjectNumber)}</li></ul></li>
        }</ul>
    </body>
</html>