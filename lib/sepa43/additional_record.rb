module Sepa43
  class AdditionalRecord < Record43
    attr_reader :data_code, :first_item, :second_item
    def initialize(record)
      super(/\A(\d{2})(\d{2})(.{38})(.{38})\z/i, record)
    end

    protected

    def validate(parts)
      parts[0] == '23' || raise('Invalid record.')
      parts[1].to_i.between?(1,5) || raise('Invalid record.')
    end

    def extract_data_from(parts)
      @data_code = parts[1].to_i
      @first_item = parts[2].strip
      @second_item = parts[3].strip
    end
  end
end