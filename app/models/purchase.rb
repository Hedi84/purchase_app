class Purchase < ApplicationRecord
  belongs_to :item
  belongs_to :user
  accepts_nested_attributes_for :item
end
