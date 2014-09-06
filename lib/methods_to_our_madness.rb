module MethodsToOurMadness
  module Shishlike
  end

  class Skewer
    include Shishlike

    def onions_only?
      true
    end

    def is_vegetarian?
      true
    end
  end

  class Onion
    include Shishlike

    attr :shish

    def initialize(shish_obj)
      @shish = shish_obj
    end

    def onions_only?
      @shish.onions_only?
    end

    def is_vegetarian?
      @shish.is_vegetarian?
    end
  end

  class Lamb
    include Shishlike

    attr :shish

    def initialize(shish_obj)
      @shish = shish_obj
    end

    def onions_only?
      false
    end

    def is_vegetarian?
      false
    end
  end

  class Tomato
    include Shishlike

    attr :shish

    def initialize(shish_obj)
      @shish = shish_obj
    end

    def onions_only?
      false
    end

    def is_vegetarian?
      @shish.is_vegetarian?
    end
  end

  module Kebablike
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
