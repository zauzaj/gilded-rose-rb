class SulfurasFactory
  def self.call(item)
    new(item).update_quality
  end

  def initialize(item)
    @item = item
  end

  def update_quality
  end
end