import strutils, sequtils

proc part1(ts: int, bs: seq[int]): int =
  var time = ts
  while true:
    for b in bs:
      if time mod b == 0:
        return (time - ts) * b
      else:
        inc time
    
proc part2(bs: seq[int]): int =
  var
    time = bs[0]
    step = 1

  for i in 0..<bs.len:
    while (time+i) mod bs[i] != 0:
      time += step
    step *= bs[i]

  return time

proc solve(input: string): (int, int) =
  let 
    lines = input.splitLines()
    ts = lines[0].parseInt
    bs = lines[1].split(',')
    bs1 = bs.filterIt(it != "x").map(parseInt)
    bs2 = bs.mapIt(it.replace("x", "1")).map(parseInt)
  
  result[0] = part1(ts, bs1)
  result[1] = part2(bs2)

echo solve(readFile("./data/day13.txt"))
