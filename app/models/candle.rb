class Candle < ApplicationRecord
    belongs_to :fragrance
    before_save :before_save
end