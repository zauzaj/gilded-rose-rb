module Factories
  class GildedRoseFactory < Factories::Base
    def update_quality
      super
      decrease_quality! if @item.quality > 0
      decrease_quality! if @item.sell_in < 0 && @item.quality > 0
    end
  end
end