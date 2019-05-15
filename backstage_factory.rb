class BackstageFactory
  def self.call(item)
    new(item).update_quality
  end

  def initialize(item)
    @item = item
  end

  def update_quality
    decrease_sell_in!
    increase_quality! if @item.quality < 50
    increase_quality! if @item.sell_in < 11 && @item.quality < 50
    increase_quality! if @item.sell_in < 6  && @item.quality < 50
    @item.quality = 0 if @item.sell_in < 0  && @item.quality < 50
  end

  private
  def decrease_sell_in!
    @item.sell_in -= 1
  end

  def decrease_quality!
    @item.quality -= 1
  end

  def increase_quality!
    @item.quality += 1
  end
end