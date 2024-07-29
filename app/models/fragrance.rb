class Fragrance < ApplicationRecord
    has_one :candle

    before_save :before_save

    def before_save
        self.name = self.name.capitalize
    end
end