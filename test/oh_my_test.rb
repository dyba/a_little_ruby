require_relative 'test_helper'

class TestOhMy < MiniTest::Test
  include OhMy

  def test_fruit_types_must_be_fruits
    apple = Apple.new
    pear = Pear.new
    lemon = Lemon.new
    fig = Fig.new
    peach = Peach.new

    assert_kind_of Apple, apple
    assert_kind_of Pear, pear
    assert_kind_of Lemon, lemon
    assert_kind_of Fig, fig
    assert_kind_of Peach, peach
  end

  def test_tree_is_split
    tree = Split.new(Bud.new, Bud.new)
    assert tree.is_split?

    tree = Bud.new
    assert tree.is_split?

    tree = Flat.new(Pear.new, Bud.new)
    refute tree.is_split?
  end

  def test_tree_has_fruit
    tree = Bud.new
    refute tree.has_fruit?

    tree = Split.new(Bud.new, Flat.new(Lemon.new, Bud.new))
    assert tree.has_fruit?
  end

  def test_tree_height
    tree = Bud.new
    assert_equal tree.height, 0

    tree = Split.new(Bud.new, Bud.new)
    assert_equal tree.height, 1

    tree = Split.new(
            Split.new(
              Flat.new(
                Pear.new,
                Bud.new),
              Split.new(
                Bud.new,
                Flat.new(
                  Apple.new,
                  Bud.new))),
            Bud.new)
    assert_equal tree.height, 4
  end

  def test_substitute_fruit
    tree = Bud.new
    assert_equal tree.occurs(Lemon.new), 0

    tree = Flat.new(Lemon.new, Bud.new)
    assert_equal tree.occurs(Lemon.new), 1

    tree = Split.new(Flat.new(Apple.new, Bud.new),
                     Flat.new(Lemon.new, Bud.new))
    assert_equal tree.occurs(Fig.new), 0
    assert_equal tree.occurs(Apple.new), 1
    assert_equal tree.occurs(Lemon.new), 1

    tree = Split.new(Split.new(Flat.new(Pear.new, Bud.new),
                               Flat.new(Pear.new, Bud.new)),
                     Split.new(Flat.new(Pear.new, Bud.new),
                               Flat.new(Pear.new, Bud.new)))
    assert_equal tree.occurs(Pear.new), 4
  end
end
