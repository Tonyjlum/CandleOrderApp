class OrdersController < ApplicationController
    def home 
        @fragrance_list = Fragrance.pluck(:name)
        @candle = Candle.new
        @errors = []
    end

    def create_order
        @dummy = Candle.new
        service = OrderService.create_order(*build_order_param)
        binding.pry
        @errors = [service.error]
        @fragrance_list = Fragrance.pluck(:name)
        redirect_to fragrances_path
        
        if @errors
        else
        end
    end

    def build_order_param
        data = params[:candle]
        fragrance_list = [data[:candle_1], data[:candle_2], data[:candle_3]]
        candles =  Candle.joins(:fragrance).where(fragrance: {name: fragrance_list})
        kit_quantity = data['quantity']
        first_name = data['first_name']
        last_name = data['last_name']
        [candles, kit_quantity, first_name, last_name]
    end

end