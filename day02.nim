import strutils, strscans

let input = "./data/day2.txt"

proc solve(input: string): (int, int) =
  var
    lo, hi: int
    letter, password: string
  for line in input.lines:
    if line.scanf("$i-$i $w: $w", lo, hi, letter, password):
      let c = letter[0]
      if password.count(c) in lo..hi: inc result[0]
      if password[lo-1] == c xor password[hi-1] == c: inc result[1]

echo solve(input)
