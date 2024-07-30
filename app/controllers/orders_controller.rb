class OrdersController < ApplicationController
    before_action :before_action
    def home 
    end

    def create_order
        service = OrderService.create_order(*build_order_param)
        if service.success == false
            flash.now[:alert] = service.message
            @data = failed_params
        else
            flash.now[:notice] = service.message
        end

        render :home
    end

    def build_order_param
        fragrance_list = [params[:candle_1], params[:candle_2], params[:candle_3]]
        candles =  Candle.joins(:fragrance).where(fragrance: {id: fragrance_list})
        kit_quantity = params['quantity']
        first_name = params['first_name']
        last_name = params['last_name']
        [candles, kit_quantity, first_name, last_name]
    end

    def failed_params
        {
            first_name: params['first_name'],
            last_name: params['last_name'],
            quantity: params['quantity'],
            candle_1: params['candle_1'],
            candle_2: params['candle_2'],
            candle_3: params['candle_3']
        }
    end

    def before_action
        @fragrance_list = Fragrance.order(:name).pluck(:name, :id).prepend(['', nil])
        @data = {}
    end

end