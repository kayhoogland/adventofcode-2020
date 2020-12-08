import strscans, strutils, sequtils,  tables

type 
  Node = tuple[color: string, count: int]
  Graph = Table[string, seq[Node]]

proc create_graph(input: string): Graph =
  for line in input.lines():  
    var 
      name, bagsString: string
    if scanf(line, "$* bags contain $*", name, bagsString):
      result[name] = @[]
      for bag in bagsString.split(",").mapIt(it.strip()):
        var
          c: int
          n: string
        if scanf(bag, "$i $* bag", c, n):
          result[name].add((n, c))

proc hasRoute(graph: Graph, startPoint, endPoint: string): bool =
  if startPoint == endPoint:
    return true
  for node in graph[startPoint]:
    result = result or graph.hasRoute(node.color, endPoint)

proc part1(graph: Graph, endPoint: string): int =
  for node, _ in graph:
    if node != endPoint and graph.hasRoute(node, endPoint):
      result.inc

proc part2(graph: Graph, startNode: string): int =
  for (color, count) in graph[startNode]:
    result += count + count * graph.part2(color)

proc solve(input: string): (int, int) =
  var graph = create_graph(input) 
  result[0] = part1(graph, "shiny gold")
  result[1] = part2(graph, "shiny gold")

echo solve("./data/day7.txt")

