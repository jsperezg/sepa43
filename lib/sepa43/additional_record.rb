module Sepa43
  class AdditionalRecord
    attr_reader :data_code, :first_item, :second_item
    def initialize(record)
      parse(record)
    end

    private

    def parse(record)
      result = record.scan(/\A(\d{2})(\d{2})(.{38})(.{1,38})\z/i)
      raise 'Invalid record.' if result.empty?

      parts = result.first
      validate(parts)
      extract_data_from(parts)
    end

    def validate(parts)
      parts[0] == '23' || raise('Invalid record.')
      parts[1].to_i.between?(1,5) || raise('Invalid record.')
    end

    def extract_data_from(parts)
      @data_code = parts[1]
      @first_item = parts[2].strip
      @second_item = parts[3].strip
    end
  end
end