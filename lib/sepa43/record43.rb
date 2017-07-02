module Sepa43
  class Record43
    def initialize(pattern, record)
      @pattern = pattern
      parse(record)
    end

    protected
    def validate(parts)
      raise 'You must implement Record43 class first.'
    end

    def extract_data_from(parts)
      raise 'You must implement Record43 class first.'
    end

    private
    def parse(record)
      result = record.scan(@pattern)
      raise "Invalid record: '#{record}'" if result.empty?

      parts = result.first
      validate(parts)
      extract_data_from(parts)
    end
  end
end