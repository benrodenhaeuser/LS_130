# write a custom implementation of `Array#each` (as a top-level method)

def each(array)
  index = 0
  while index < array.length
    yield(array[index])
    index += 1
  end
  array
end

p each([0, 1, 2]) { |elem| puts elem }.select { |elem| elem.even? }
