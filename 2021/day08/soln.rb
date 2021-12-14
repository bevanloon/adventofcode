class Display
  attr_reader :digits

  def initialize
    @digits = {}
  end

  def format(data)
    data.lines.
      map(&:chomp).
      map { |el| el.split(" | ") }
  end

  def input
    format(File.read("input.txt"))
  end

  def test_input
    format(File.read("test_input.txt"))
  end

  def a(data=input)
    y = data.flat_map { |el| el[1].split }

    y.select do |item|
      "2347".include?(item.length.to_s)
    end
  end

  def length_to_digit
    {
      2 => 1,
      3 => 7,
      4 => 4,
      7 => 8,
    }
  end

  def concat_and_split(data)
    data.flat_map(&:split).collect do |item|
      item.split("")
    end
  end

  def b(data=input)
    digits = {}
    data = concat_and_split(data)

    easy = data.select { |el| "2347".include?(el.length.to_s) }
    easy.each do |item|
      digit = length_to_digit[item.length]
      key = item.sort.join
      digits[digit] = item
    end

    data.each do |elem|
      if elem.length == 5
        if (elem - digits[1]).length == 3
          digits[3] = elem
        elsif (elem - digits[4]).length == 2
          digits[5] = elem
        else
          digits[2] = elem
        end
      end
      if elem.length == 6
        if (elem - digits[4]).length == 2
          digits[9] = elem
        elsif (elem - digits[1]).length == 4
          digits[0] = elem
        else
          digits[6] = elem
        end
      end
    end

    digits
  end

  def calculate_score(output_values, decoder)
    ret_str = ""
    output_values.each do |val|
      decoder.each do |k,v|
        ret_str += k.to_s if (v.sort == val.split("").sort)
      end
    end
    ret_str.to_i
  end
end


x = Display.new
data = x.input

# part 1
p x.a(data).count

# part 2
res = data.inject(0) do |sum, datum|
  decoder = x.b(datum)
  sum += x.calculate_score(datum[1].split, decoder)
end
p res
