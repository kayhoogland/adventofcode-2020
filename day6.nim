import strutils, sequtils, tables

proc solve(path: string): (int, int) =
  let answers = readFile path

  for answer in answers.split("\n\n"):
    var groupAnswer = replace(answer, "\n", "")
    var letterFrequencies = toCountTable(groupAnswer)

    result[0] += len(letterFrequencies)
    
    var groupSize = countLines(answer.strip())
    var countSeq = toSeq(letterFrequencies.values)
    result[1] += len(countSeq.filterIt(it == groupSize))

echo solve "./data/day6.txt"
