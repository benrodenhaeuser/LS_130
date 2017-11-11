def compare(str)
  puts "Before: #{str}"
  puts "After: #{yield(str)}"
end

compare('hi') { |word| word.upcase }
