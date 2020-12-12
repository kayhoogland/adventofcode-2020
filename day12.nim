import tables, strutils

let steerTable = {
  'L': {'E': 'N', 'N': 'W', 'W': 'S', 'S': 'E'}.toTable,
  'R': {'E': 'S', 'N': 'E', 'W': 'N', 'S': 'W'}.toTable
}.toTable

proc steer(inst: char, value: int, d: char): char = 
  var (value, d) = (value, d)

  while value != 0:
    d = steerTable[inst][d]
    value -= 90

  return d

proc part1(input: string): int =
  var 
    d = 'E'
    x, y: int

  for line in input.lines():
    var 
      inst = line[0] 
      value = parseInt(line[1..^1])

    if inst == 'F': inst = d

    case inst:
      of {'L', 'R'}: d = steer(inst, value, d)
      of 'N': y += value
      of 'E': x += value
      of 'S': y -= value
      of 'W': x -= value
      else: discard

  return abs(x) + abs(y)

proc rot(inst: char, value: int, wx, wy: int): (int, int) =
  var (value, wx, wy) = (value, wx, wy)
  
  while value != 0:
    if inst == 'R':
      (wx, wy) = (wy, wx * -1)
    elif inst == 'L':
      (wx, wy) = (wy * -1, wx)
    value -= 90

  return (wx, wy) 

proc part2(input: string): int =
  var
    (wx, wy) = (10, 1)
    x, y: int

  for line in input.lines():
    var
      inst = line[0]
      value = parseInt(line[1..^1])

    case inst:
      of 'F':
        x += wx * value
        y += wy * value
      of {'L', 'R'}: (wx, wy) = rot(inst, value, wx, wy)
      of 'N': wy += value
      of 'E': wx += value
      of 'S': wy -= value
      of 'W': wx -= value
      else: discard

  return abs(x) + abs(y)

proc solve(input: string): (int, int) = 
  result[0] = part1(input)
  result[1] = part2(input)

echo solve("./data/day12.txt")
