require_relative './gilded_rose_factory'

module Factories
  class ConjuredFactory < Factories::GildedRoseFactory
    def update_quality
      super
    end

    private
    def decrease_quality!
      @item.quality -= 2
    end
  end
end