class Item < ApplicationRecord
  belongs_to :item_option
  belongs_to :purchase
end
