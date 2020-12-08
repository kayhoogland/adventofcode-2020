import strscans

type RuleList = seq[tuple[step: string, value: int]]

proc create_rule_list(input: string): RuleList =
  for line in input.lines:
    var
      step: string
      value: int
    if scanf(line, "$w $i", step, value): 
      result.add((step, value))
  
proc part1(ruleList: RuleList): (bool, int) =
  var 
    pos: int
    seen: seq[int]
  
  while true and pos < ruleList.len():
    if pos in seen:
      return (true, result[1])
    seen.add(pos)
    var value = ruleList[pos].value
    case ruleList[pos].step:
      of "acc":
        result[1] += value
        inc pos
      of "jmp":
        pos += value
      of "nop":
        inc pos

proc part2(ruleList: RuleList): int =
  var ruleList = ruleList
  for i in 0..<ruleList.len():
    var loop: bool
    let oldStep = ruleList[i].step
    case ruleList[i].step:
      of "jmp":
        ruleList[i].step = "nop"
      of "nop":
        ruleList[i].step = "jmp"
      else: continue
    (loop, result) = part1(ruleList) 
    if not loop: return
    ruleList[i].step = oldStep
    

proc solve(input: string): (int, int) =
  var 
    ruleList = create_rule_list(input)
  result[0] = part1(rulelist)[1]
  result[1] = part2(ruleList)
  
echo solve("./data/day8.txt")
