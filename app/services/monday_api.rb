require 'net/http'

class MondayApiError < StandardError; end

class MondayApi
    # RETRY_LIMIT = 3
    MONDAY_DOT_COM_API_URI = 'https://api.monday.com/v2/'
    API_KEY = ENV['MONDAY_API_KEY']
    BOARD_ID = ENV['MONDAY_BOARD_ID']
    
    def initialize(order: nil, fragrance: nil)
        @order = order
        # @retry = RETRY_LIMIT
        @response = nil
    end

    def self.submit_order(order)
        raise ArgumentError.new('Missing Order') unless order
        new(order: order).submit_order
    end 

    def self.create_fragrance(fragrance)
        #remove this logic, no longer needed
        raise ArgumentError.new('Missing Fragrance') unless fragrance
        new(fragrance: fragrance).create_fragrance
    end

    def submit_order
        binding.pry
        request(create_order_mutation_request_body)
        handle_response
    end

    def create_fragrance(fragrance)
        request(create_fragrance_request_body)
        handle_response
    end

    def request(request_body)
        uri = URI(MONDAY_DOT_COM_API_URI)
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true
        request = Net::HTTP::Post.new(uri.path, request_headers)
        request.body = request_body.to_json
        @response = http.request(request)
    end

    def handle_response
        raise MondayApiError.new("Error occured: #{@response.body.code}") unless @response.code == "200"

        parse_response = JSON.parse(@response.body)
        raise MondayApiError.new("Error occured: #{parse_response['errors'].map{|e| e['message']}.join(', ')}") if parse_response['errors']

        parse_response
    end

    def request_headers
        {
            'Authorization' => API_KEY,
            'Content-Type' => 'application/json'
        }
    end

    def create_order_mutation_request_body
         {
            query: <<-GRAPHQL
            mutation{
                create_item(
                  board_id: #{BOARD_ID},
                  item_name: "#{@order.item_name}",
                  create_labels_if_missing: true,
                  column_values: \"\""#{create_order_column_values.to_json}"\"\"
                ){
                    id
                }
              }
          GRAPHQL
          }
    end

    def create_order_column_values
        { 
            numbers: @order.kit_quantity, 
            dropdown: {labels: @order.candle_lables}, 
            status: {label: 'New Order'},
            date_1: Date.today.to_s,
            text: @order.first_name,
            text6: @order.last_name,
        }
    end

    def create_fragrance_request_body

    end

    def create_fragrance_column_values
        {
            dropdown: @fragrance.name
        }
    end
end