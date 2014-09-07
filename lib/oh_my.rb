require 'singleton'

module OhMy
  class Fruit
  end

  class Tree
  end

  module Equatable
    def == obj
      self.instance_of?(obj.class)
    end
  end

  class Peach < Fruit
    include Equatable
  end

  class Apple < Fruit
    include Equatable
  end

  class Pear < Fruit
    include Equatable
  end

  class Lemon < Fruit
    include Equatable
  end

  class Fig < Fruit
    include Equatable
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
      if @old_obj == fruit
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

  class Bud < Tree
    include Treelike

    def accept(ask)
      ask.for_bud
    end
  end

  class Flat < Tree
    include Treelike

    def initialize(fruit, tree)
      @fruit, @tree = fruit, tree
    end

    def accept(ask)
      ask.for_flat(@fruit, @tree)
    end
  end

  class Split < Tree
    include Treelike

    def initialize(left_tree, right_tree)
      @left_tree, @right_tree = left_tree, right_tree
    end

    def accept(ask)
      ask.for_split(@left_tree, @right_tree)
    end
  end
end
