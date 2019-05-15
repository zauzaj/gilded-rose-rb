module Factories
  class BackstageFactory < Factories::Base
    def update_quality
      super
      increase_quality!
      increase_quality! if @item.sell_in < 11
      increase_quality! if @item.sell_in < 6
      drop_quality!     if @item.sell_in < 0
    end

    def drop_quality!
      @item.quality = 0
    end
  end
end