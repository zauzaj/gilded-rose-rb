module Factories
  class AgedBrieFactory < Factories::Base

    def update_quality
      super
      increase_quality!
      increase_quality! if @item.sell_in < 0
    end
  end
end