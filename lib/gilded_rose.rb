class GildedRose
  def initialize(items)
    @items = items
  end

  AGED_BRIE = "Aged Brie"
  BACKSTAGE_PASS = "Backstage passes to a TAFKAL80ETC concert"
  SULFURAS = "Sulfuras, Hand of Ragnaros"

  class ItemUpdater
    attr_reader :item, :quality_delta

    def initialize(item, quality_delta)
      @item = item
      @quality_delta = quality_delta
    end

    def update
      update_item_quality(item, quality_delta)
      update_item_quality(item, quality_delta) if expired?(item)
    end
  end

  class BackstagePassUpdater < ItemUpdater
    def quality_delta
      if expired?(item)
        -item.quality
      elsif item.sell_in < 5
        3
      elsif item.sell_in < 10
         2 
      else
        @quality_delta
      end
    end
  end

  def update_quality
    @items.each do |item|

      if item.name != SULFURAS
        item.sell_in = item.sell_in - 1
      end

      case item.name
      when BACKSTAGE_PASS
        BackstagePassUpdater.new(item, 1).update        
      when AGED_BRIE
        ItemUpdater.new(item, 1).update
      when SULFURAS
        #DO NOTHING
      else
        ItemUpdater.new(item, -1).update
      end
    end
  end
end

def expired?(item)
    item.sell_in < 0
  end

def update_item_quality(item, quality_delta)
    if item.quality < 50 && item.quality > 0
      item.quality += quality_delta
    end
  end
