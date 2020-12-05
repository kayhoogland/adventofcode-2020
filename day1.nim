import strutils
import sequtils

let numbers = toSeq("./data/day1.txt".lines).map(parseInt)

proc part1(numbers: seq[int]): int =
  block loop:
    for index in 0..<numbers.len:
      for second_index in index+1..<numbers.len:
        if numbers[index] + numbers[second_index] == 2020:
          result = numbers[index] * numbers[second_index]
          break loop

proc part2(numbers: seq[int]): int =
  block outer:
    for i in 0..<numbers.len:
      for j in i+1..<numbers.len:
        block inner:
          for k in j+1..<numbers.len:
            if numbers[i] + numbers[j] > 2020:
              break inner
            elif numbers[i] + numbers[j] + numbers[k] == 2020:
              result = numbers[i] * numbers[j] * numbers[k]
              break outer

proc solve(numbers: seq[int]): (int, int) =
  result[0] = part1(numbers)
  result[1] = part2(numbers)

echo solve(numbers)
