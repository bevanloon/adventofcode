#initial_position_of_crabs = [16,1,2,0,4,2,7,1,2,14]

def nth_triangular(num)
  num * (num + 1) / 2
end

def b
  initial_position_of_crabs = File.read("input.txt").split(",").map(&:to_i)

  min = initial_position_of_crabs.min
  max = initial_position_of_crabs.max
  min_fuel_cost_so_far = 0
  best_position_so_far = 0

  (min..max).each do |final_position|
    total_fuel_cost_for_this_position = 0
    initial_position_of_crabs.each do |crab|
      total_fuel_cost_for_this_position += nth_triangular (crab - final_position).abs
    end
    if min_fuel_cost_so_far > total_fuel_cost_for_this_position || min_fuel_cost_so_far == 0
      min_fuel_cost_so_far = total_fuel_cost_for_this_position
      best_position_so_far = final_position
    end
  end

  puts best_position_so_far
  puts min_fuel_cost_so_far
end

def a
  initial_position_of_crabs = File.read("input.txt").split(",").map(&:to_i)

  min = initial_position_of_crabs.min
  max = initial_position_of_crabs.max
  min_fuel_cost_so_far = 0
  best_position_so_far = 0

  (min..max).each do |final_position|
    total_fuel_cost_for_this_position = 0
    initial_position_of_crabs.each do |crab|
      total_fuel_cost_for_this_position += (crab - final_position).abs
    end
    if min_fuel_cost_so_far > total_fuel_cost_for_this_position || min_fuel_cost_so_far == 0
      min_fuel_cost_so_far = total_fuel_cost_for_this_position
      best_position_so_far = final_position
    end
  end

  puts best_position_so_far
  puts min_fuel_cost_so_far
end

a
b
