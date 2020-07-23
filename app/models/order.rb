class Order < ApplicationRecord
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :item,    presence: true
  validates :details, presence: true, length: { maximum: 80 }
  validates :vendor,  presence: true
  validates :size,    presence: true
  validates :zone,    presence: true
end
