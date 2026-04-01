declare variable $songs := //songTitle;
declare variable $locations := $songs/@originLocation/string() => distinct-values();
declare variable $xspacer := 10;
declare variable $yspacer := 25;

<svg xmlns="http://www.w3.org/2000/svg" width="100%" height="{count($locations) * $yspacer + 150}">
    <g transform="translate(280, 100)">
        <g>
            <text x="0" y="-5" font-family="sans-serif" font-size="20px" fill="black"> # of Shanties per Country in The Music of the Waters</text>
        </g>
        <g>
            {
                for $loc at $pos in $locations
                let $loc-song-count := $songs[@originLocation = $loc] => count()
                order by $loc-song-count descending
                return
                    <g>
                        <text x="-10" y="{$pos * $yspacer + 5}" font-family="sans-serif" font-size="12px" fill="black" text-anchor="end">{$loc}</text>
                        <line x1="0" y1="{$pos * $yspacer}" x2="{$loc-song-count * $xspacer}" y2="{$pos * $yspacer}" stroke="blue" stroke-width="15"/>
                        <text x="{$loc-song-count * $xspacer + 10}" y="{$pos * $yspacer + 5}" font-family="sans-serif" font-size="12px" fill="black">{$loc-song-count}</text>
                        <line x1="0" y1="0" x2="0" y2="{($pos + 1) * $yspacer}" stroke="black" stroke-width="2"/>
                    </g>
            }
        </g>
    </g>
</svg>