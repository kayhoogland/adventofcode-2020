import tables, sequtils

type 
  Coordinate = tuple[x: int, y:int, z:int, w:int]
  Coordinates = seq[Coordinate]
  Lookup = Table[Coordinate, char]

proc create_lookup(input: string): Lookup =
  var i = 0
  for line in input.lines():
    for j in 0..<line.len:
      result[(i, j, 0, 0)] = line[j]
    inc i

proc is_active(c: Coordinate, l: Lookup): int =
  if l.getOrDefault(c, '.') == '.': return 0
  return 1

proc count_active_neighbors(c: Coordinate, lookup: Lookup, useW: bool): (int, Coordinates) =
  var rangeW: HSlice[int, int]
  if useW: rangeW = -1..1
  else: rangeW = 0..0

  for x in -1..1:
    for y in -1..1:
      for z in -1..1:
        for w in rangeW:
          if x == 0 and y == 0 and z == 0 and w==0: continue
          let n = (c[0]+x, c[1]+y, c[2]+z, c[3]+w)
          if not lookup.hasKey(n):
            result[1].add(n)
            continue
          result[0] += n.is_active(lookup)

proc solver(lookup: Lookup, cycles: int, useW: bool): int =
  var lookup = lookup

  for i in 0..<cycles:
    let active = toSeq(lookup.keys).filterIt(lookup[it] == '#')
    var lookUpCopy = lookup

    for c in active:
      var (count, toAdd) = c.count_active_neighbors(lookup, useW)
      if count in 2..3: lookUpCopy[c] = '#'
      else: lookUpCopy[c] = '.'

      # Add cubes to the lookup with an active neighbor (c)
      for a in toAdd:
        if not lookup.hasKey(a):
          lookUp[a] = '.'

    let inactive = toSeq(lookup.keys).filterIt(lookup[it] == '.')
    for c in inactive:
      var (count, _) = c.count_active_neighbors(lookup, useW)
      if count == 3: lookUpCopy[c] = '#'

    lookup = lookUpCopy

  return toSeq(lookup.keys).filterIt(lookup[it] == '#').len

proc solve(input: string): (int, int) =
  let lookup = create_lookup(input)
  result[0] = solver(lookup, 6, false)
  result[1] = solver(lookup, 6, true)
  

echo solve("./data/day17.txt")
