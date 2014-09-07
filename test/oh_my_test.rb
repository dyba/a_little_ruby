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
    assert tree.accept(IsSplit)

    tree = Bud.new
    assert tree.accept(IsSplit)

    tree = Flat.new(Pear.new, Bud.new)
    refute tree.accept(IsSplit)
  end

  def test_tree_has_fruit
    tree = Bud.new
    refute tree.accept(HasFruit)

    tree = Split.new(Bud.new, Flat.new(Lemon.new, Bud.new))
    assert tree.accept(HasFruit)
  end

  def test_tree_height
    tree = Bud.new
    assert_equal tree.accept(Height), 0

    tree = Split.new(Bud.new, Bud.new)
    assert_equal tree.accept(Height), 1

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
    assert_equal tree.accept(Height), 4
  end

  def test_substitute_fruit
    tree = Bud.new
    assert_equal tree.accept(Occurs.new(Lemon.new)), 0

    tree = Flat.new(Lemon.new, Bud.new)
    assert_equal tree.accept(Occurs.new(Lemon.new)), 1

    tree = Split.new(Flat.new(Apple.new, Bud.new),
                     Flat.new(Lemon.new, Bud.new))
    assert_equal tree.accept(Occurs.new(Fig.new)), 0
    assert_equal tree.accept(Occurs.new(Apple.new)), 1
    assert_equal tree.accept(Occurs.new(Lemon.new)), 1

    tree = Split.new(Split.new(Flat.new(Pear.new, Bud.new),
                               Flat.new(Pear.new, Bud.new)),
                     Split.new(Flat.new(Pear.new, Bud.new),
                               Flat.new(Pear.new, Bud.new)))
    assert_equal tree.accept(Occurs.new(Pear.new)), 4
  end
end
