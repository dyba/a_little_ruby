module OhMy
  class Fruit
  end

  class Tree
  end

  class Peach < Fruit
  end

  class Apple < Fruit
  end

  class Pear < Fruit
  end

  class Lemon < Fruit
  end

  class Fig < Fruit
  end

  class Bud < Tree
    def accept(ask)
      ask.for_bud
    end
  end

  module IsFlat
    module_function

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

  module IsSplit
    module_function

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

  module HasFruit
    module_function

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

  module Height
    module_function

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

  module Substitute
    module_function

    def for_bud
    end

    def for_flat(fruit, tree)
    end

    def for_split(left_tree, right_tree)
    end
  end

  class Flat < Tree
    def initialize(fruit, tree)
      @fruit, @tree = fruit, tree
    end

    def accept(ask)
      ask.for_flat(@fruit, @tree)
    end
  end

  class Split < Tree
    def initialize(left_tree, right_tree)
      @left_tree, @right_tree = left_tree, right_tree
    end

    def accept(ask)
      ask.for_split(@left_tree, @right_tree)
    end
  end
end
