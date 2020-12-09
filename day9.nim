import strutils, sequtils

proc sum_in_prev(r: seq[int], n: int): bool =
  result = false
  for i in 0..24:
    if r[i] > n: continue
    for j in i+1..24: 
      if r[i] + r[j] == n: 
        return true

proc part1(ns: seq[int]): (int, int) =
  for i in 25..<ns.len():
    let window = ns[i-25..<i]
    if not sum_in_prev(window, ns[i]): 
      return (ns[i], i)

proc part2(ns: seq[int], pos: int): int =
  let num = ns[pos]
  for i in 0..<pos:
    let arr = ns[i..<pos]
    for s in 1..<arr.len():
      let 
        window = arr[0..s]
        sum = window.foldl(a+b, 0)
      if sum > num: break
      if sum == num:
        return window[minIndex(window)] + window[maxIndex(window)] 

  
proc solve(input: string): (int, int) =
  var ns: seq[int]
  for line in input.lines(): ns.add(parseInt(line))

  var pos: int
  (result[0], pos) = part1(ns)
  result[1] = part2(ns, pos)

echo solve("./data/day9.txt")
