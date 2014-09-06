module BoringProtocols
  class Remover
    def initialize(obj)
      @obj = obj
    end

    def for_bottom
      Bottom.new
    end

    def for_topping(topping, pie)
      if @obj == topping
        pie.accept(self)
      else
        Topping.new(topping, pie.accept(self))
      end
    end
  end

  class Substituter
    def initialize(new_obj, old_obj)
      @new_obj, @old_obj = new_obj, old_obj
    end

    def for_bottom
      Bottom.new
    end

    def for_topping(topping, pie)
      if @old_obj == topping
        Topping.new(@new_obj, pie.accept(self))
      else
        Topping.new(topping, pie.accept(self))
      end
    end
  end

  module Pielike
    def remover
      @remover ||= Remover.new
    end

    def substituter
      @substituter ||= Substituter.new
    end
  end

  class Bottom
    def accept(ask)
      ask.for_bottom
    end
  end

  class Topping
    def initialize(topping, pie)
      @topping, @pie = topping, pie
    end

    def accept(ask)
      ask.for_topping(@topping, @pie)
    end
  end
end
