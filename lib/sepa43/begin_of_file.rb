require 'date'
require 'sepa43/record43'

module Sepa43
  class BeginOfFile < Record43
    attr_reader :bank_code, :accounting_date

    def initialize(record)
      super(/\A(\d{2})(\d{4})(\d{6}).{68}\z/i, record)
    end

    protected

    def validate(parts)
      parts[0] == '00' || raise('Invalid record.')
    end

    def extract_data_from(parts)
      @bank_code = parts[1]
      @accounting_date = Date.parse(parts[2])
    end
  end
end