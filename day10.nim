import strutils, algorithm, tables

proc part1(ns: seq[int]): int =
  var
    prev: int
    diffFrequenies = initCountTable[int]()

  for n in ns:
    diffFrequenies.inc(n - prev)
    prev = n

  return diffFrequenies[1] * diffFrequenies[3]

proc part2(ns: seq[int]): int =
  var 
    countTable = initTable[int, int]()
    ns = ns

  # Check for every charger how many paths there are to
  # get there. Which is the sum of the paths of all the 
  # reachable other jolts.
  countTable[0] = 1

  for n in ns:
    countTable[n] = (
      countTable.getOrDefault(n-1) + 
      countTable.getOrDefault(n-2) + 
      countTable.getOrDefault(n-3))

  return countTable[ns.max]

proc solve(input: string): (int, int) =
  var ns: seq[int]
  for line in input.lines(): 
    ns.add(parseInt(line))

  # Add the jolt of the phone
  ns.add(ns.max + 3)
  ns.sort()

  result[0] = part1(ns)
  result[1] = part2(ns)

echo solve("./data/day10.txt")
