def input()
  File.read("in.txt")
end

def create_call_numbers
  input.lines.first.chomp.split(",")
end

def all_card_lines
  input.lines[2..]
end

def create_cards
  # first line represents call numbers
  # second line is \n, third line starts the board definitions
  data = input.lines[2..]
  data.chunk_while do |first, last|
    first.chomp != ""
  end.map do |board|
    board.map(&:split).reject(&:empty?)
  end
end

def cross_off_number(card, number)
  card.each do |line|
    line.each_with_index do |elem, index|
      line[index] = -1 if elem == number
    end
  end
end
def a
  call_numbers = create_call_numbers
  cards = create_cards

  call_numbers.each do |number|
    cards.each do |card|
      cross_off_number(card, number)
      cols = card.transpose
      one = card.select { |l| l.all?(-1) }
      two = cols.select { |l| l.all?(-1) }
      if !one.empty? ||  !two.empty?
        puts number.to_i * card.flatten.reject { |e| e == -1 }.map(&:to_i).sum
        exit
      end
    end
  end
end

def b
  call_numbers = create_call_numbers
  cards = create_cards
  high_call = 0
  last_card = 0

  cards.each_with_index do |card, card_index|
    call_numbers.each_with_index do |number, call_index|
      cross_off_number(card, number)
      cols = card.transpose
      one = card.select { |l| l.all?(-1) }
      two = cols.select { |l| l.all?(-1) }
      if !one.empty? || !two.empty?
        if call_index > high_call
          high_call = call_index
          last_card = card_index
        end
        break
      end
    end
  end

  puts call_numbers[high_call].to_i * cards[last_card].flatten.reject { |e| e == -1 }.map(&:to_i).sum
end

a
b
