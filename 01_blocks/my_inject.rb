# write a custom implementation of `Array#reduce` (as a top-level method)

def reject(array, starting_value = false)
  if starting_value
    accumulator = starting_value
    the_array = array
  else
    accumulator = array.first
    the_array = array[1..-1]
  end

  index = 0
  while index < the_array.length
    accumulator = yield(accumulator, the_array[index])
    index += 1
  end

  accumulator
end

inject([[1], [2], [3], [4]]) { |acc, value| acc + value }
# should return [1, 2, 3, 4]
