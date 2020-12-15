import tables

proc solver(input: seq[int], limit: int): int =
  var table: Table[int, int]

  for i in 0..<input.len():
    table[input[i]] = i+1

  for n in input.len+1..<limit:
    let nextNum = n - table.getOrDefault(result, n)
    table[result] = n
    result = nextNum

proc solve(input: seq[int]): (int, int) =
  result[0] = solver(input, 2020)
  result[1] = solver(input, 30000000)

echo solve(@[0,20,7,16,1,18,15])
