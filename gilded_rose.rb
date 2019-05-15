require 'pry-rails'
require_relative './sulfuras_factory'
require_relative './aged_brie_factory'
require_relative './backstage_factory'

class GildedRose
  FACTORIES = {
    'Sulfuras, Hand of Ragnaros' => 'Sulfuras',
    'Aged Brie' => 'AgedBrie',
    'Backstage passes to a TAFKAL80ETC concert' => 'Backstage'
  }.freeze

  def initialize(items)
    @items = items
  end

  def update_quality()
    @items.each do |item|
      #Sulfuras never has to be sold or decreases in Quality
      # if item.name != 'Sulfuras, Hand of Ragnaros'
      #   item.sell_in = item.sell_in - 1
      # end
      # if item.name != 'Aged Brie' and item.name != 'Backstage passes to a TAFKAL80ETC concert'
      #   if item.quality > 0
      #     #Sulfuras never has to be sold or decreases in Quality
      #     #Some other factory
      #     if item.name != 'Sulfuras, Hand of Ragnaros'
      #       item.quality = item.quality - 1
      #     end
      #   end
      # else
      #   #AgedBrieFactory & BackstageFactory
      #   if item.quality < 50
      #     item.quality = item.quality + 1
      #     #BackstageFactory
      #     if item.name == 'Backstage passes to a TAFKAL80ETC concert'
      #       if item.sell_in < 11
      #         if item.quality < 50
      #           item.quality = item.quality + 1
      #         end
      #       end
      #       if item.sell_in < 6
      #         if item.quality < 50
      #           item.quality = item.quality + 1
      #         end
      #       end
      #     end
      #   end
      # end
      # if item.sell_in < 0
      #   if item.name != 'Aged Brie'
      #     if item.name != 'Backstage passes to a TAFKAL80ETC concert'
      #       if item.quality > 0
      #         #Some other factory
      #         if item.name != 'Sulfuras, Hand of Ragnaros'
      #           item.quality = item.quality - 1
      #         end
      #       end
      #     else
      #       #BackstageFactory.drop_quality
      #       item.quality = item.quality - item.quality
      #     end
      #   else
      #     #AgedBrieFactory.increas_quality
      #     if item.quality < 50
      #       item.quality = item.quality + 1
      #     end
      #   end
      # end
      factory = get_factory(item)
      factory.call(item)
    end
  end

  private
  def get_factory(item)
    fac_name = FACTORIES[item.name]
    Object.const_get "#{fac_name}Factory"
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
