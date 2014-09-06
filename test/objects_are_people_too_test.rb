require_relative 'test_helper'

class TestObjectsArePeopleToo < MiniTest::Test
  include ObjectsArePeopleToo

  def test_instances_of_pizza_pie
    pizza_pie = Topping.new(Anchovy.new,
                            Topping.new(Tuna.new,
                                        Topping.new(Anchovy.new,
                                                    Bottom.new))) 
    assert_kind_of PizzaPielike, pizza_pie

    pizza_pie = Topping.new(Salmon.new,
                            Topping.new(Anchovy.new,
                                        Topping.new(Tuna.new,
                                                    Topping.new(Anchovy.new,
                                                                Topping.new(Tuna.new,
                                                                            Bottom.new)))))
    assert_kind_of PizzaPielike, pizza_pie
  end

  def test_equality_of_fish
    assert Anchovy.new == Anchovy.new
    assert Tuna.new == Tuna.new
    assert Salmon.new == Salmon.new

    refute Anchovy.new == Salmon.new
    refute Tuna.new == Anchovy.new
    refute Anchovy.new == Salmon.new
  end

  def test_remove_fish
    pizza_pie = Topping.new(Anchovy.new,
                            Bottom.new)
    assert_kind_of PizzaPielike, pizza_pie.remove_fish(Anchovy.new)
  end
end
