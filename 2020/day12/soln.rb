input_data = <<HEREDOC
pg-CH
pg-yd
yd-start
fe-hv
bi-CH
CH-yd
end-bi
fe-RY
ng-CH
fe-CH
ng-pg
hv-FL
FL-fe
hv-pg
bi-hv
CH-end
hv-ng
yd-ng
pg-fe
start-ng
end-FL
fe-bi
FL-ks
pg-start
HEREDOC


sample_input = <<HEREDOC
start-A
start-b
A-c
A-b
b-d
A-end
b-end
HEREDOC

def format(input)
  input.lines.collect { |s| s.chomp.split("-") }
end

def build_graph(data)
  graph = {}

  data.each do |a, b|
    graph[a] ||= []
    graph[a] << b

    graph[b] ||= []
    graph[b] << a
  end

  graph
end

def in_visited?(cave, visited, allowed_twice)
  return true if cave == "start"
  only_lower_case = visited.reject { |x| x.upcase == x }
  if cave == allowed_twice
    return only_lower_case.include?(cave) && only_lower_case.count(cave) > 1
  else
    return only_lower_case.include?(cave)
  end
end

def walk(graph, current_cave, visited, allowed_twice, every_path)
  if current_cave == "end"
    return every_path.append(visited)
  end

  graph[current_cave].each do |cave|
    next if in_visited?(cave, visited, allowed_twice)
    walk(graph, cave, visited + [cave], allowed_twice, every_path)
  end

  every_path
end

inp = format(input_data)
map = build_graph(inp)
lower_case_caves = inp.flatten.uniq.select { |cave| cave != "start" && cave != "end" && cave.upcase != cave }
path_parta = []
path_partb = []
map.each do |k, v|
  if k == "start"
    path_parta += walk(map, k, [], "", [])
    lower_case_caves.each do |lcc|
      path_partb += walk(map, k, [], lcc, [])
    end
  end
end

puts "Part 1"
puts path_parta.uniq.count
puts
puts "Part 2"
puts path_partb.uniq.count
