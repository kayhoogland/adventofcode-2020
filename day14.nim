import strutils, strscans, tables, math

proc combinations(mask: string): seq[int] =
  let
    countX = mask.count("X")
    combinationCount = 2^countX

  for c in 0..<combinationCount:
    var 
      maskCopy = mask
      j: int
    let fillValues = c.toBin(countX)

    for i in 0..<mask.len():
      if maskCopy[i] == 'X':
        maskCopy[i] = fillValues[j]
        inc j

    result.add(maskCopy.parseBinInt())

proc solver(input: string, part: char): int =
  var
    mask: string
    mem_num: int
    mem_val: int
    values: Table[int, int]

  for line in input.lines():
    if scanf(line, "mask = $*", mask): continue
    if scanf(line, "mem[$i] = $i", mem_num, mem_val):

      if part == '1':
        var mem_num_bin = mem_val.toBin(36)
        for i in 0..35:
          if mask[i] != 'X':
            mem_num_bin[i] = mask[i]

        values[mem_num] = mem_num_bin.parseBinInt()

      elif part == '2':
        var mem_val_bin = mem_num.toBin(36)
        for i in 0..35:
          if mask[i] in {'X', '1'}:
            mem_val_bin[i] = mask[i]

        for c in combinations(mem_val_bin):
          values[c] = mem_val


  for v in values.values:
    result += v


proc solve(input: string): (int, int) =
  result[0] = solver(input, '1')
  result[1] = solver(input, '2')

echo solve("./data/day14.txt")
