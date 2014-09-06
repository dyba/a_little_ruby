require 'singleton'

module ObjectsArePeopleToo
  class FishRemover
    include Singleton

    def for_bottom(fishlike)
      Bottom.new
    end

    def for_topping(obj, pizza_pie_like, fishlike)
      if obj == fishlike
        pizza_pie_like.remove_fish(fishlike)
      else
        Topping.new(obj, pizza_pie_like.remove_fish(fishlike))
      end
    end
  end

  module PizzaPielike
    def fish_remover
      FishRemover.instance
    end
  end

  class Bottom
    include PizzaPielike

    def remove_fish(fishlike)
      fish_remover.for_bottom(fishlike)
    end
  end

  class Topping
    include PizzaPielike

    attr :obj
    attr :pizza_pie

    def initialize(o, p)
      @obj = o
      @pizza_pie = p
    end

    def remove_fish(fishlike)
      fish_remover.for_topping(self, @pizza_pie, fishlike)
    end
  end

  module Fishlike
  end

  class Anchovy
    include Fishlike

    def == (obj)
      obj.kind_of? Anchovy
    end
  end

  class Salmon
    include Fishlike

    def == (obj)
      obj.kind_of? Salmon
    end
  end

  class Tuna
    include Fishlike

    def == (obj)
      obj.kind_of? Tuna
    end
  end
end
