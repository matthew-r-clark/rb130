system 'clear'
require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require "minitest/reporters"
Minitest::Reporters.use!

require_relative 'todolist'

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

  def test_add_todo
    @todo4 = Todo.new("Test")
    @list.add(@todo4)
    assert_equal([@todo1, @todo2, @todo3, @todo4], @list.to_a)
  end

  def test_add_shovel
    @todo4 = Todo.new("Test")
    @list << @todo4
    assert_equal([@todo1, @todo2, @todo3, @todo4], @list.to_a)
  end

  def test_adding_non_todo_object_raises_type_error
    assert_raises(TypeError) { @list << 4 }
  end

  def test_size
    assert_equal(3, @list.size)
  end

  def test_first
    assert_equal(@todo1, @list.first)
  end

  def test_last
    assert_equal(@todo3, @list.last)
  end

  def test_to_a
    assert_equal([@todo1, @todo2, @todo3], @list.to_a)
    refute_same([@todo1, @todo2, @todo3], @list.to_a)
  end

  def test_done?
    refute(@list.done?)
    @list.done!
    assert(@list.done?)
  end

  def test_item_at
    assert_equal(@todo2, @list.item_at(1))
    assert_raises(IndexError) {@list.item_at(100)}
  end

  def test_mark_done_at
    @list.mark_done_at(1)
    assert(@todo2.done?)
    assert_raises(IndexError) {@list.mark_done_at(100)}
  end

  def test_mark_undone_at
    @list.done!
    @list.mark_undone_at(1)
    refute(@todo2.done?)
    assert_raises(IndexError) {@list.mark_undone_at(100)}
  end

  def test_done!
    @list.done!
    assert(@list.done?)
  end

  def test_shift
    shifted = @list.shift
    assert_equal(@todo1, shifted)
    assert_equal([@todo2, @todo3], @list.to_a)
  end

  def test_pop
    popped = @list.pop
    assert_equal(@todo3, popped)
    assert_equal([@todo1, @todo2], @list.to_a)
  end

  def test_remove_at
    @list.remove_at(1)
    assert_equal([@todo1, @todo3], @list.to_a)
    assert_raises(IndexError) {@list.remove_at(100)}
  end

  def test_each
    assert_equal(@list, @list.each {nil})
    result = []
    @list.each {|todo| result << todo}
    assert_equal([@todo1, @todo2, @todo3], result)
  end

  def test_select
    @todo2.done!
    assert_equal([@todo1, @todo3], @list.select {|todo| !todo.done?}.to_a)
    refute_same(@list, @list.select {true})
  end

  def test_to_s
    output = <<-OUTPUT.chomp.gsub /^\s+/, ""
    --- Today's Todos ---
    [ ] Buy milk
    [ ] Clean room
    [ ] Go to gym
    OUTPUT
  
    assert_equal(output, @list.to_s)
  end

  def test_to_s_one_todo_done
    output = <<-OUTPUT.chomp.gsub /^\s+/, ""
    --- Today's Todos ---
    [ ] Buy milk
    [X] Clean room
    [ ] Go to gym
    OUTPUT
  
    @todo2.done!
    assert_equal(output, @list.to_s)
  end

  def test_to_s_all_todos_done
    output = <<-OUTPUT.chomp.gsub /^\s+/, ""
    --- Today's Todos ---
    [X] Buy milk
    [X] Clean room
    [X] Go to gym
    OUTPUT
  
    @list.done!
    assert_equal(output, @list.to_s)
  end

  def test_find_by_title
    assert_equal(@todo1, @list.find_by_title("buy milk"))
    assert_nil(@list.find_by_title('hello'))
  end

  def test_all_done
    assert_equal([], @list.all_done.to_a)
    @todo2.done!
    assert_equal([@todo2], @list.all_done.to_a)
  end

  def test_all_not_done
    assert_equal([@todo1, @todo2, @todo3], @list.all_not_done.to_a)
    @todo2.done!
    assert_equal([@todo1, @todo3], @list.all_not_done.to_a)
  end

  def test_mark_done
    @list.mark_done('buy milk')
    assert(@todo1.done?)
  end

  def test_mark_all_done
    @list.mark_all_done
    assert(@list.done?)
  end

  def test_mark_all_undone
    @list.mark_all_undone
    refute(@list.done?)
  end
end