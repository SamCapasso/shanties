declare variable $xValue := 100;
declare variable $yValue := 50;
declare variable $book := doc("../xml/MusicOfTheWaters.xml");
declare variable $songTitles := $book//songTitle;
declare variable $subjects := $songTitles/@subject/data()=>distinct-values();

<svg xmlns = "http://www.w3.org/2000/svg" viewbox = "1000 750">
    <desc>XQuery entered data for total number of shanties by type</desc>
    <g alignment-baseline = "baseline" transform = "translate (25, 100)">
        <!-- Title -->
        <text x = "425" y = "0" text-anchor = "middle" font-size = "36">Number of Shanties by Subject</text>
        <!-- Data and Labels -->
        <g>
            {
                for $subject in $subjects
                    for $index in (1, 2, 3, 4, 5, 6, 7, 8, 9, 10)
                        let $yValue := $yValue + 50 * ($index - 1)
                        let $subjectCount := $songTitles[./@subject = $subject]=>count()
                        where $subjectCount > 0
                        order by $subjectCount descending
                        return
                            <g>
                                <text x = "{$xValue} - 10" y = "{$yValue} + 34" text-anchor = "end">{$subject}</text>
                                <line x1 = "{$xValue}" y1 = "{$yValue} + 30" x2 = "{$xValue} + {$subjectCount} * 10" y2 = "{$yValue} + 30" stroke = "blue" stroke-width = "40"/>
                                <text x = "{$xValue} + {$subjectCount} * 10 + 10" y = "{$yValue} + 34" text-anchor = "start">{$subjectCount}</text>
                            </g>
            }
        </g>
        <!-- Axis -->
        <line x1 = "{$xValue}" y1 = "{$yValue}" x2 = "{$xValue}" y2 = "{$yValue} + 510" stroke = "black"/>
    </g>
</svg>