Dir["./factories/*.rb"].each {|file| require file }

class GildedRose
  FACTORIES = {
    'Sulfuras, Hand of Ragnaros' => 'Sulfuras',
    'Aged Brie' => 'AgedBrie',
    'Backstage passes to a TAFKAL80ETC concert' => 'Backstage',
    'Conjured Mana Cake' => 'Conjured'
  }.freeze

  def initialize(items)
    @items = items
  end

  def update_quality()
    @items.each do |item|
      factory = get_factory(item)
      factory.call(item)
    end
  end

  private
  def get_factory(item)
    fac_name = FACTORIES[item.name]
    begin
      Object.const_get "Factories::#{fac_name}Factory"
    rescue NameError
      Object.const_get "Factories::GildedRoseFactory"
    end
  end
end

class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s()
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end
