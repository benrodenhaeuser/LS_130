require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require "minitest/reporters"
Minitest::Reporters.use!

require_relative 'todo_list'

class TodoListTest < MiniTest::Test

  def setup
    @todo1 = Todo.new("Buy milk")
    @todo2 = Todo.new("Clean room")
    @todo3 = Todo.new("Go to gym")
    @todos = [@todo1, @todo2, @todo3]

    @list = TodoList.new("Today's Todos")
    @list.add(@todo1)
    @list.add(@todo2)
    @list.add(@todo3)
  end

  def test_to_a
    assert_equal(@todos, @list.to_a)
  end

  def test_size
    assert_equal(@todos.size, @list.size)
  end

  def test_first
    assert_equal(@todo1, @list.first)
  end

  def test_last
    assert_equal(@todo3, @list.last)
  end

  def test_shift
    shifted_elem = @list.shift
    assert_equal(@todo1, shifted_elem)
    assert_equal([@todo2, @todo3], @list.to_a)
  end

  def test_pop
    popped_elem = @list.pop
    assert_equal(@todo3, popped_elem)
    assert_equal([@todo1, @todo2], @list.to_a)
  end

  def test_done_predicate
    refute(@list.done?)
  end

  def test_raises_type_error_if_non_todo_is_added
    assert_raises(TypeError) do
     @list.add(1)
   end
  end

  def test_adding_a_todo
    todo = Todo.new("Test the todo list class")
    @list.add(todo)
    @todos << todo
    assert_equal(@todos, @list.to_a)
  end

  def test_shovel_aliases_add
    todo = Todo.new("Test the todo list class")
    @list << todo
    @todos << todo
    assert_equal(@todos, @list.to_a)
  end

  def test_item_at
    todo = @list.item_at(0)
    assert_equal(@todo1, todo)
    assert_raises(IndexError) do
      @list.item_at(10)
    end
  end

  def test_mark_done_at
    @list.mark_done_at(0)
    assert(@list.item_at(0).done?)
    refute(@list.item_at(1).done?)
    assert_raises(IndexError) do
      @list.mark_done_at(100)
    end
  end

  def test_mark_undone_at
    @list.mark_undone_at(1)
    refute(@list.item_at(1).done?)
    refute(@list.item_at(0).done?)
    assert_raises(IndexError) do
      @list.mark_undone_at(100)
    end
  end

  def test_done_bang
    @list.done!
    assert(@todos.all? { |todo| todo.done? })
  end

  def test_remove_at
    @list.remove_at(0)
    assert_equal(@todo2, @list.item_at(0))
    assert_equal(@todo3, @list.item_at(1))
    assert_raises(IndexError) do
      @list.remove_at(100)
    end
  end

  def test_to_s
    output = <<~OUTPUT.chomp
    [ ] Buy milk
    [ ] Clean room
    [ ] Go to gym
    OUTPUT

    assert_equal(output, @list.to_s)
  end

  def test_to_s2
    @todo2.done!

    output = <<~OUTPUT.chomp
    [ ] Buy milk
    [X] Clean room
    [ ] Go to gym
    OUTPUT

    assert_equal(output, @list.to_s)
  end

  def test_to_s3
    @list.done!

    output = <<~OUTPUT.chomp
    [X] Buy milk
    [X] Clean room
    [X] Go to gym
    OUTPUT

    assert_equal(output, @list.to_s)
  end

  def test_each
    todos = []

    @list.each do |todo|
      todos << todo
    end

    assert_equal(@todos, todos)
  end

  def test_each2
    return_value = @list.each { }
    assert_equal(@list, return_value)
  end

  def test_select
    @todo1.done!
    list = TodoList.new(@list.title)
    list.add(@todo1)

    assert_equal(list.title, @list.title)
    assert_equal(list.to_s, @list.select{ |todo| todo.done? }.to_s)
  end
end
