import strutils, strscans, sequtils, tables

type 
  Rules = seq[HSlice[int, int]]
  Ticket = seq[int]
  Tickets = seq[Ticket]

proc parse_rules(field: string): Table[string, Rules] =
  var
    name: string
    low1, high1, low2, high2: int
  for line in field.splitLines:
    if scanf(line, "$+: $i-$i or $i-$i", name, low1, high1, low2, high2):
      result[name] = @[low1..high1, low2..high2]

proc parse_tickets(field: string): Tickets =
  let field = field.split("\n", 1)[1].strip
  for ticket in field.splitLines:
    result.add(ticket.split(",").map(parseInt))

proc int_is_valid(field: int, rules: Rules): bool =
  result = false
  for r in rules:
    if field in r: return true

proc seq_is_valid(ticket: Ticket, rules: Rules): bool =
  result = true
  for f in ticket:
    if not f.int_is_valid(rules): return false

proc create_columns(tickets: Tickets): Table[int, seq[int]] =
  for i in 0..<20: result[i] = @[]
  for t in tickets:
    for j in 0..<t.len:
      result[j].add(t[j])

proc part1(tickets: Tickets, rules: Rules): int =
  for t in tickets:
    for f in t:
      if not f.int_is_valid(rules):
        result += f

proc part2(tickets: Tickets, myTicket: Ticket, rules: Rules, ruleSets: Table[string, Rules]): int =
  let validTickets = tickets.filterIt(it.seq_is_valid(rules))
  let columns = validTickets.create_columns
  var 
    options: Table[string, seq[int]]
    lookUp: Table[string, int]

  for n, rs in ruleSets:
    options[n] = @[]
    for i, c in columns:
      if c.seq_is_valid(rs): options[n].add(i)

  while lookUp.len != options.len:
    for n, o in options:
      if o.len == 1:
        lookUp[n] = o[0]
        for i, ns in options:
          options[i] = options[i].filterIt(it != o[0])

  result = 1
  for n, c in lookUp:
    if n.contains("departure"):
      result *= myTicket[c]


proc solve(input: string): (int, int) =
  let fields = input.split("\n\n")
  let ruleSets = fields[0].parse_rules
  let myTicket = fields[1].parse_tickets[0]
  let tickets = fields[2].parse_tickets

  var rules: Rules

  for s in ruleSets.values:
    for r in s: rules.add(s)
  
  result[0] = part1(tickets, rules)
  result[1] = part2(tickets, myTicket, rules, ruleSets)

echo solve(readFile "./data/day16.txt")
