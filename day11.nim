import tables, sequtils

type Layout = Table[int, string]

proc create_layout(input: string): Layout =
  var
    i: int
    layout: Layout

  for line in input.lines():
    layout[i] = line
    inc i

  return layout

proc seat(layout: Layout, row: int, col: int): char =
    let seats = layout.getOrDefault(row, "")
    if seats.len() == 0 or col notin 0..<seats.len():
      return '-'
    else:
      return seats[col]

proc count_adjacent(layout: Layout, row: int, col: int): CountTable[char] =
  for r in -1..1:
    for c in -1..1:
      if r == 0 and c == 0:
        continue
      result.inc(layout.seat(row+r, col+c))

proc part1(layout: Layout): int =
  var
    oldLayout = layout
    newLayout = layout

  while true:
    var changeCount: int
    for r in 0..<oldLayout.len():
      for c in 0..<oldLayout[r].len():
        let
          counts = oldLayout.count_adjacent(r, c)
          seat = oldLayout.seat(r, c)
        if seat == 'L' and counts.getOrDefault('#') == 0:
          newLayout[r][c] = '#'
          inc changeCount
        elif seat == '#' and counts.getOrDefault('#') >= 4:
          newLayout[r][c] = 'L'
          inc changeCount

    if changeCount == 0:
      for r in oldLayout.values():
        result += count(r, '#')
      break

    oldLayout = newLayout

proc look(layout: Layout, row, col, dx, dy: int): char =
  var
    row = row
    col = col
  while true:
    row += dx
    col += dy
    let seat = layout.seat(row, col)
    if seat == '-':
      return '-'
    elif seat == '.':
      continue
    elif seat in {'#', 'L'}:
      return seat

proc count_adjacent_2(layout: Layout, row: int, col: int): CountTable[char] =
  for r in -1..1:
    for c in -1..1:
      if r == 0 and c == 0:
        continue
      else:
        result.inc(layout.look(row, col, r, c))

proc part2(layout: Layout): int =
  var
    oldLayout = layout
    newLayout = layout
    count: int

  while true:
    var changeCount: int
    for r in 0..<oldLayout.len():
      for c in 0..<oldLayout[r].len():
        let
          counts = oldLayout.count_adjacent_2(r, c)
          seat = oldLayout.seat(r, c)
        if seat == 'L' and counts.getOrDefault('#') == 0:
          newLayout[r][c] = '#'
          inc changeCount
        elif seat == '#' and counts.getOrDefault('#') >= 5:
          newLayout[r][c] = 'L'
          inc changeCount

    if changeCount == 0:
      for r in oldLayout.values():
        result += count(r, '#')
      break

    oldLayout = newLayout

proc solve(input: string): (int, int) =
  let layout = create_layout(input)
  result[0] = part1(layout) 
  result[1] = part2(layout)


echo solve("./data/day11.txt")

