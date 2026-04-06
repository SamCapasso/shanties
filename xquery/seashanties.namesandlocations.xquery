for $song in //songTitle[@str and @originLocation]
return
  <song>
    <title>{string($song/@str)}</title>
    <country>{string($song/@originLocation)}</country>
  </song>