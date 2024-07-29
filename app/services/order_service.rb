class OrderService

    class InvalidOrderConfigurationError < StandardError; end

    attr_reader :candle_array, :candle_1, :candle_2, :candle_3, :kit_quantity, :first_name, :last_name, :item_name

    def initialize(candle_array, kit_quantity, first_name, last_name)
        @candle_array = candle_array
        @candle_1, @candle_2, @candle_3 = candle_array
        @kit_quantity = kit_quantity&.to_i
        @first_name = first_name
        @last_name = last_name
        @item_name = "Order for #{@first_name} #{@last_name}"
    end

    def self.create_order(candle_array, kit_quantity, first_name, last_name)
        service = new(candle_array, kit_quantity, first_name, last_name)
        service.validate_order
        service.create_order
        OpenStruct.new(order: service, message: 'Order was successfuly submitted.', success: true)
    rescue InvalidOrderConfigurationError, MondayApiError => error
        #flash this error in controller
        binding.pry
        OpenStruct.new(
            order: service,
            error: error.message,
            success: false
        )
    end

    def create_order
        MondayApi.submit_order(self)
    end

    def validate_order
        provided_only_three_candles? &&
        has_three_unique_fragrances? &&
        positive_kit_quantity_value?
    end

    def provided_only_three_candles?
        return true if @candle_array.length == 3

        raise InvalidOrderConfigurationError.new("Invalid number of candles. Provided #{@candle_array.length}, expected 3.")
    end

    def has_three_unique_fragrances?
        uniq_fragrances_count = [@candle_1.fragrance_id, @candle_2.fragrance_id, @candle_3.fragrance_id].uniq.length
        return true if uniq_fragrances_count == 3

        raise InvalidOrderConfigurationError.new("Invalid number of fragrances. Provided #{uniq_fragrances_count}, expected 3.")
    end

    def positive_kit_quantity_value?
        return true if @kit_quantity > 0

        raise InvalidOrderConfigurationError.new("Orders must have one or more kits. Provided #{@kit_quantity}.")
    end

    def candle_lables
        [@candle_1.fragrance.name, @candle_2.fragrance.name, @candle_3.fragrance.name]
    end
end