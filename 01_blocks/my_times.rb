# write a custom implementation of `Integer#times` (as a top-level method)

def times(integer)
  counter = 0
  while counter < integer
    yield(counter)
    counter += 1
  end
  integer
end

times(5) { puts 'hello world' }

# method times invoked in line 12
# argument 5 is bound to method local variable `integer`
# counter set to 0 (line 4)
# we start a loop: (line 4)
# `counter` is less than `integer`, so we execute the while loop:
# we yield to the block (line 12), passing 0 (counter) to the block
# the block ignores that 0 was passed, printing 'hello world'
# the flow returns to line 6. the return value of line 6 is nil.
# we continue with line 6, incrementing the counter
# we go to the beginning of the while loop again
# counter is still less than integer, so we iterate the while loop another time
# we yield to the block, passing 1
# ... and so on
