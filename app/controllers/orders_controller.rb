class OrdersController < ApplicationController
    def home 
        @fragrance_list = Fragrance.order(:name).pluck(:name, :id)
        @data = {}
        @errors = []
    end

    def create_order
        service = OrderService.create_order(*build_order_param)
        @fragrance_list = Fragrance.order(:name).pluck(:name, :id)
        if service.success == false
            flash.now[:alert] = service.message
            @data = failed_params
        else
            flash.now[:notice] = service.message
            @data = {}
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

end