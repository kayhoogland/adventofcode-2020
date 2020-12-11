let input = "./data/day3.txt"

proc solve(input: string, inc_column: int, inc_row: int): int =
  var row, column: int = 0
  for line in input.lines:
    if row mod inc_row == 0:
      if line[column mod len(line)] == '#': inc result
      column += inc_column
    inc row

echo solve(input, 3, 1)

proc part2(input: string): int =
  result = 1
  for stride in @[@[1, 1], @[3, 1], @[5, 1], @[7, 1], @[1, 2]]:
    result *= solve(input, stride[0], stride[1])

echo part2(input)

