sample_input = <<HEREDOC
[({(<(())[]>[[{[]{<()<>>
[(()[<>])]({[<{<<[]>>(
{([(<{}[<>[]}>{[]{[(<()>
(((({<>}<{<{<>}{[]{[]{}
[[<[([]))<([[{}[[()]]]
[{[{({}]{}}([{[{{{}}([]
{<[[]]>}<{[{[{[]{()[[[]
[<(<(<(<{}))><([]([]()
<{([([[(<>()){}]>(<<{{
<{([{{}}[<[[[<>{}]]]>[]]
HEREDOC

def completion_points
  {
    ")" => 1,
    "]" => 2,
    "}" => 3,
    ">" => 4
  }
end

def points
  {
    ")" => 3,
    "]" => 57,
    "}" => 1197,
    ">" => 25137
  }
end

def pairs
  {
    "[" => "]",
    "{" => "}",
    "(" => ")",
    "<" => ">"
  }
end

def input(data)
  data.lines.map(&:chomp)
end

def is_opening_char?(character)
  "([{<".include?(character)
end

def is_incomplete?(line)
  # we want to test for a malformed line
  # if it is malformed, return false
  chunks = []
  line.each_char do |token|
    if is_opening_char?(token)
      chunks << token
    else
      previous_token = chunks.pop
      unless pairs[previous_token] == token
        return false
      end
    end
  end
  return true
end

def completion(line)
  chunks = []
  line.each_char do |token|
    if is_opening_char?(token)
      chunks << token
    else
      chunks.pop
    end
  end

  complete_by = chunks.collect do |token|
    pairs[token]
  end.reverse
end

def calculate_score(tags)
  tags.inject(0) do |acc, tag|
    (acc * 5) + completion_points[tag]
  end
end

def part2(data)
  incomplete_lines = data.select do |line|
    is_incomplete?(line)
  end

  completion_tags = incomplete_lines.collect do |line|
    completion(line)
  end

  scores = completion_tags.collect do |tags|
    calculate_score(tags)
  end

  # we want the middle score - integer division will ignore the remainder
  # and since we're 0 indexed, dividing by 2 gives us the mid point
  scores.sort![scores.length / 2]
end

def check_syntax(data)
  score = 0
  data.each do |line|
    chunks = []
    line.each_char do |token|
      if is_opening_char?(token)
        chunks << token
      else
        previous_token = chunks.pop
        unless pairs[previous_token] == token
          score += points[token]
          break
        end
      end
    end
  end
  score
end

puts "part 1:"
p check_syntax(input(File.read("input.txt")))
puts "part 2:"
data = input(File.read("input.txt"))
p part2(data)
