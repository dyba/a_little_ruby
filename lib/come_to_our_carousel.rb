module ComeToOurCarousel
  # OnionsOnly
  #
  # contains methods that correspond to each subclass of Shish
  # We've encapsulated the data for the onions_only? method of
  # each subclass of Shish
  module OnionsOnly
    def for_skewer
      true
    end

    def for_onion(shish_obj)
      shish_obj.onions_only?
    end

    def for_lamb(shish_obj)
      false
    end

    def for_tomato(shish_obj)
      false
    end

    [:for_skewer, :for_lamb, :for_tomato, :for_onion].each do |m|
      module_function m
    end
  end

  # IsVegetarian
  #
  # contains methods that correspond to each subclass of Shish
  # We've encapsulated the data for the is_vegetarian? method of
  # each subclass of Shish
  module IsVegetarian
    def for_skewer
      true
    end

    def for_onion(shish_obj)
      shish_obj.is_vegetarian?
    end

    def for_lamb(shish_obj)
      false
    end

    def for_tomato(shish_obj)
      shish_obj.is_vegetarian?
    end

    [:for_skewer, :for_lamb, :for_tomato, :for_onion].each do |m|
      module_function m
    end
  end

  module Shishlike
    def onions_only_validator
      OnionsOnly
    end

    def vegetarian_validator
      IsVegetarian
    end
  end

  class Skewer
    include Shishlike

    def onions_only?
      onions_only_validator.for_skewer
    end

    def is_vegetarian?
      vegetarian_validator.for_skewer
    end
  end

  class Onion
    include Shishlike

    attr :shish

    def initialize(shish_obj)
      @shish = shish_obj
    end

    def onions_only?
      onions_only_validator.for_onion(@shish)
    end

    def is_vegetarian?
      vegetarian_validator.for_onion(@shish)
    end
  end

  class Lamb
    include Shishlike

    attr :shish

    def initialize(shish_obj)
      @shish = shish_obj
    end

    def onions_only?
      onions_only_validator.for_lamb(@shish)
    end

    def is_vegetarian?
      vegetarian_validator.for_lamb(@shish)
    end
  end

  class Tomato
    include Shishlike

    attr :shish

    def initialize(shish_obj)
      @shish = shish_obj
    end

    def onions_only?
      onions_only_validator.for_tomato(@shish)
    end

    def is_vegetarian?
      vegetarian_validator.for_tomato(@shish)
    end
  end

  module Kebablike
    def is_veggie?
      true
    end

    def holder
      self
    end
  end

  class Holder
    include Kebablike

    attr :obj

    def initialize(o)
      @obj = o
    end

    def is_veggie?
      true
    end

    def holder
      @obj
    end
  end

  class Shallot
    include Kebablike

    attr :kebab

    def initialize(kebab_obj)
      @kebab = kebab_obj
    end

    def is_veggie?
      @kebab.is_veggie?
    end

    def holder
      @kebab.holder
    end
  end

  class Shrimp
    include Kebablike

    attr :kebab

    def initialize(kebab_obj)
      @kebab = kebab_obj
    end

    def is_veggie?
      false
    end

    def holder
      @kebab.holder
    end
  end

  class Radish
    include Kebablike

    attr :kebab

    def initialize(kebab_obj)
      @kebab = kebab_obj
    end

    def is_veggie?
      @kebab.is_veggie?
    end

    def holder
      @kebab.holder
    end
  end

  class Pepper
    include Kebablike

    attr :kebab

    def initialize(kebab_obj)
      @kebab = kebab_obj
    end

    def is_veggie?
      @kebab.is_veggie?
    end

    def holder
      @kebab.holder
    end
  end

  class Zucchini
    include Kebablike

    attr :kebab

    def initialize(kebab_obj)
      @kebab = kebab_obj
    end

    def is_veggie?
      @kebab.is_veggie?
    end

    def holder
      @kebab.holder
    end
  end

  module Rodlike
  end

  class Dagger
    include Rodlike
  end

  class Sabre
    include Rodlike
  end

  class Sword
    include Rodlike
  end

  module Platelike
  end

  class Gold
    include Platelike
  end

  class Silver
    include Platelike
  end

  class Brass
    include Platelike
  end

  class Copper
    include Platelike
  end

  class Wood
    include Platelike
  end
end
