require 'sepa43/record43'

module Sepa43
  class EndOfFile < Record43
    attr_reader :records

    def initialize(record)
      super(/\A(\d{2})9{18}(\d{6}).{54}\z/i, record)
    end

    protected

    def validate(parts)
      parts[0] == '88' || raise('Invalid record.')
    end

    def extract_data_from(parts)
      @records = parts[1].to_i
    end
  end
end