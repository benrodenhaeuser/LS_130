class Todo
  DONE_MARKER = 'X'
  UNDONE_MARKER = ' '

  attr_accessor :title, :description, :done

  def initialize(title, description='')
    @title = title
    @description = description
    @done = false
  end

  def done!
    self.done = true
  end

  def done?
    done
  end

  def undone!
    self.done = false
  end

  def to_s
    "[#{done? ? DONE_MARKER : UNDONE_MARKER}] #{title}"
  end
end

class TodoList
  # include Enumerable

  attr_accessor :title

  def initialize(title)
    @title = title
    @todos = []
  end

  def add(todo)
    raise TypeError, "not a Todo object" unless todo.instance_of?(Todo)
    @todos << todo
  end

  alias_method :<<, :add

  def size
    @todos.size
  end

  def first
    @todos.first
  end

  def last
    @todos.last
  end

  def item_at(index)
    @todos.fetch(index)
  end

  def mark_done_at(index)
    item_at(index).done!
  end

  def mark_undone_at(index)
    item_at(index).undone!
  end

  def shift
    @todos.shift
  end

  def pop
    @todos.pop
  end

  def remove_at(index)
    @todos.fetch(index)
    @todos.delete_at(index)
  end

  def done!
    @todos.each_index { |idx| mark_done_at(idx) }
  end

  def to_s
    @todos.map(&:to_s).join("\n")
  end

  def to_a
    @todos
  end

  def each
    counter = 0
    while counter < @todos.length # more straightforward: just use `Array#each`
      yield(@todos[counter])
      counter += 1
    end
    self
  end

  def select
    selected = TodoList.new('Current selection:')
    each do |item|
      selected.add(item) if yield(item)
    end
    selected
  end

  def find_by_title(key)
    each do |todo|
      return todo if todo.title == key
    end
    nil
  end

  def all_done
    select do |todo|
      todo.done?
    end
  end

  def all_not_done
    select do |todo|
      !todo.done?
    end
  end

  def mark_done(key)
    todo = find_by_title(key)
    todo.done! if todo
  end

  def mark_all_done
    each do |todo|
      todo.done!
    end
  end

  def mark_all_undone
    each do |todo|
      todo.undone!
    end 
  end
end
