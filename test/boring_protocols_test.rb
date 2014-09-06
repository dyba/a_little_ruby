require 'test_helper'

class TestBoringProtocols < MiniTest::Test
  include BoringProtocols

  class Anchovy
    def == obj
      self.instance_of? obj
    end
  end

  def test_removes_objects
    pie = Topping.new(Anchovy.new, Bottom.new)

    pie.accept(Remover.new(Anchovy.new))
  end

end
