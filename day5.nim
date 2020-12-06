import sequtils, sets

proc row(input: string): int =
  var
    low = 0.0
    high = 128.0
  for i in 0..5:
    if input[i] == 'F': high -= (high - low) / 2
    else: low = (low + high) / 2

  if input[6] == 'F': return int(low)
  else: return int(high) - 1
  

proc column(input: string): int =
  var
    low = 0.0
    high = 8.0
  for i in 7..8:
    if input[i] == 'L': high -= (high - low) / 2
    else: low = (low + high) / 2

  if input[9] == 'L': return int(low)
  else: return int(high) - 1

proc seat(input: string): int =
  let 
    row = row(input)
    column = column(input)

  return row * 8 + column

proc solve(input: string): (int, HashSet[int]) =
  var seats: seq[int]
  for line in input.lines:
    seats.add(seat(line))
  result[0] = seats.max
  result[1] = (seats.min..seats.max).toSeq.toHashSet - seats.toHashSet

echo solve("./data/day5.txt")
