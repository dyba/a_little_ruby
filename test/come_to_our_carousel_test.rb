require_relative 'test_helper'

class TestComeToOurCarousel < MiniTest::Test
  include ComeToOurCarousel

  def test_contains_only_onions
    skewer = Onion.new(Onion.new(Onion.new(Skewer.new)))
    assert skewer.onions_only?

    skewer = Onion.new(Tomato.new(Onion.new(Skewer.new)))
    refute skewer.onions_only?

    skewer = Lamb.new(Tomato.new(Onion.new(Skewer.new)))
    refute skewer.onions_only?
  end

  def test_is_vegetarian
    skewer = Onion.new(Tomato.new(Skewer.new))
    assert skewer.is_vegetarian?

    skewer = Lamb.new(Tomato.new(Skewer.new))
    refute skewer.is_vegetarian?

    skewer = Tomato.new(Onion.new(Skewer.new))
    assert skewer.is_vegetarian?
  end

  def test_is_veggie
    kebab = Shallot.new(Radish.new(Holder.new(Gold.new)))
    assert kebab.is_veggie?

    kebab = Shallot.new(Shrimp.new(Holder.new(Gold.new)))
    refute kebab.is_veggie?

    kebab = Shrimp.new(Shallot.new(Holder.new(Gold.new)))
    refute kebab.is_veggie?

    kebab = Shrimp.new(Shallot.new(Holder.new(Wood.new)))
    refute kebab.is_veggie?
  end

  def test_holder
    kebab = Shallot.new(Radish.new(Holder.new(Dagger.new)))
    assert_instance_of Dagger, kebab.holder

    kebab = Shallot.new(Radish.new(Holder.new(Gold.new)))
    assert_instance_of Gold, kebab.holder
  end
end
