class FragranceService
    class InvalidFragranceConfigurationError < StandardError; end

    attr_reader :fragrance
    def initalize(fragrance)
        @fragrance = fragrance
    end

    def self.create_fragrance
        new(fragrance).create_fragrance
    end

    def self.update_fragrance

    end

    def self.delete_fragrance

    end

    def create_fragrance
        # before save, we call the api to add it in, if its successful, we allow the save
        MondayApi.create_fragrance(@fragrance)
    end
end