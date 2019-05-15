module Factories
  class Base
    def self.call(item)
      new(item).update_quality
    end

    def initialize(item)
      @item = item
    end

    def update_quality
      decrease_sell_in!
    end

    private
    def decrease_sell_in!
      @item.sell_in -= 1
    end

    def decrease_quality!
      @item.quality -= 1
    end

    def increase_quality!
      @item.quality += 1 unless quality_max_reached?
    end

    def quality_max_reached?
      @item.quality >= 50
    end
  end
end