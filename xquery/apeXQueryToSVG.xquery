declare variable $xValue := 100;
declare variable $yValue := 00;
declare variable $book := doc("../xml/MusicOfTheWaters.xml");
declare variable $songTitles := $book//songTitle;
declare variable $subjects := $songTitles/@subject/data()=>distinct-values();

<svg xmlns = "http://www.w3.org/2000/svg" viewbox = "1000 750">
    <desc>XQuery entered data for total number of shanties by type</desc>
    <g alignment-baseline = "baseline" transform = "translate (25, 100)">
        <!-- Title -->
        <text x = "375" y = "25" text-anchor = "middle" font-size = "36">Number of Shanties by Subject</text>
        <!-- Data and Labels -->
        <g>
            {
                for $subject at $index in $subjects
                    let $yValue := $yValue + 50
                    let $subjectCount := $songTitles[./@subject = $subject]=>count()
                    where $subjectCount > 0
                    order by $subjectCount descending
                    count $index
                    return
                        <g>
                            <text x = "{$xValue - 10}" y = "{$index * $yValue + 34}" text-anchor = "end">{$subject}</text>
                            <line x1 = "{$xValue}" y1 = "{$index * $yValue + 30}" x2 = "{$xValue + $subjectCount * 10}" y2 = "{$index * $yValue + 30}" stroke = "blue" stroke-width = "40"/>
                            <text x = "{$xValue + $subjectCount * 10 + 10}" y = "{$index * $yValue + 34}" text-anchor = "start">{$subjectCount}</text>
                        </g>
            }
        </g>
        <!-- Axis -->
        <line x1 = "{$xValue}" y1 = "{$yValue + 50}" x2 = "{$xValue}" y2 = "{$yValue + 560}" stroke = "black"/>
    </g>
</svg>