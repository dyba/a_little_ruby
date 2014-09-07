require 'singleton'

module OhMy
  module Fruitlike
    def == obj
      self.instance_of?(obj.class)
    end
  end

  class Peach
    include Fruitlike
  end

  class Apple
    include Fruitlike
  end

  class Pear
    include Fruitlike
  end

  class Lemon
    include Fruitlike
  end

  class Fig
    include Fruitlike
  end

  class IsFlat
    include Singleton

    def for_flat(fruit, tree)
      tree.accept(self)
    end

    def for_split(left_tree, right_tree)
      false
    end

    def for_bud
      true
    end
  end

  class IsSplit
    include Singleton

    def for_flat(fruit, tree)
      false
    end

    def for_split(left_tree, right_tree)
      left_tree.accept(self) || right_tree.accept(self)
    end

    def for_bud
      true
    end
  end

  class HasFruit
    include Singleton

    def for_bud
      false
    end

    def for_flat(fruit, tree)
      true
    end

    def for_split(left_tree, right_tree)
      left_tree.accept(self) || right_tree.accept(self)
    end
  end

  class Height
    include Singleton

    def for_bud
      0
    end

    def for_flat(fruit, tree)
      tree.accept(self) + 1
    end

    def for_split(left_tree, right_tree)
      [left_tree.accept(self), right_tree.accept(self)].max + 1
    end
  end

  class Substitute
    def initialize(new_fruit, old_fruit)
      @new_fruit, @old_fruit = new_fruit, old_fruit
    end

    def for_bud
      Bud.new
    end

    def for_flat(fruit, tree)
      if @old_fruit == fruit
        Flat.new(@new_fruit, tree.accept(self))
      else
        Flat.new(fruit, tree.accept(self))
      end
    end

    def for_split(left_tree, right_tree)
      Split.new(left_tree.accept(self), right_tree.accept(self))
    end
  end

  class Occurs
    def initialize(fruit)
      @fruit = fruit
    end

    def for_bud
      0
    end

    def for_flat(fruit, tree)
      if @fruit == fruit
        1 + tree.accept(self)
      else
        tree.accept(self)
      end
    end

    def for_split(left_tree, right_tree)
      left_tree.accept(self) + right_tree.accept(self)
    end
  end

  module Treelike
    def is_split?
      accept(IsSplit.instance)
    end

    def has_fruit?
      accept(HasFruit.instance)
    end

    def is_flat?
      accept(IsFlat.instance)
    end

    def height
      accept(Height.instance)
    end

    def substitute(old_fruit, new_fruit)
      accept(Substitute.new(old_fruit, new_fruit))
    end

    def occurs(fruit)
      accept(Occurs.new(fruit))
    end
  end

  class Bud
    include Treelike

    def accept(ask)
      ask.for_bud
    end
  end

  class Flat
    include Treelike

    def initialize(fruit, tree)
      @fruit, @tree = fruit, tree
    end

    def accept(ask)
      ask.for_flat(@fruit, @tree)
    end
  end

  class Split
    include Treelike

    def initialize(left_tree, right_tree)
      @left_tree, @right_tree = left_tree, right_tree
    end

    def accept(ask)
      ask.for_split(@left_tree, @right_tree)
    end
  end
end
