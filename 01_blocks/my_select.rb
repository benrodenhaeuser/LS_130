# write a custom implementation of `Array#select` (as a top-level method)

def select(array)
  selected = []
  array.each do |elem|
    selected << elem if yield(elem)
  end
  selected
end

p select([0, 1, 2, 3, 4]) { |elem| elem.odd? }
