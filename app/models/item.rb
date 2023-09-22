class Item < ApplicationRecord
  belongs_to :item_option
  has_one :purchase

  def update_allocation
    item_option.update(allocation: item_option.allocation - 1)
  end
end
