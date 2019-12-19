class GildedRose
  def initialize(items)
    @items = items
  end

  AGED_BRIE = "Aged Brie"
  BACKSTAGE_PASS = "Backstage passes to a TAFKAL80ETC concert"
  SULFURAS = "Sulfuras, Hand of Ragnaros"

  def update_quality
    @items.each do |item|

      if item.name != SULFURAS
        item.sell_in = item.sell_in - 1
      end

      case item.name

      when BACKSTAGE_PASS
        update_item_quality(item, 1)
        if item.name == BACKSTAGE_PASS
          if item.sell_in < 10
            update_item_quality(item, 1)
          end
          if item.sell_in < 5
            update_item_quality(item, 1)
          end
        end
        update_item_quality(item, -item.quality) if expired?(item)
      when AGED_BRIE
        update_item_quality(item, 1)
        update_item_quality(item, 1) if expired?(item)
      when SULFURAS
        #DO NOTHING
      else
        update_item_quality(item, -1)
        update_item_quality(item, -1) if expired?(item)
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

end
