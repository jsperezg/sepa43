require 'date'
require 'sepa43/balance_code'
require 'sepa43/record43'

module Sepa43
  class TransactionRecord < Record43
    attr_reader :branch_code, :transaction_date, :value_date, :shared_item, :own_item, :balance_code, :amount, :document_number,
                :reference_1, :reference_2

    def initialize(record)
      super(/\A(\d{2}).{4}(\d{4})(\d{6})(\d{6})(\d{2})(\d{3})(\d)(\d{14})(\d{10})(\d{12})(.{16})\z/i, record)
    end

    protected

    def validate(parts)
      parts[0] == '22' || raise('Invalid record.')
    end

    def extract_data_from(parts)
      @branch_code = parts[1]
      @transaction_date = Date.parse(parts[2])
      @value_date = Date.parse(parts[3])
      @shared_item = parts[4]
      @own_item = parts[5]
      @balance_code = BalanceCode.new(parts[6])
      @amount = parts[7].to_f / 100.0
      @document_number = parts[8]
      @reference_1 = parts[9]
      @reference_2 = parts[10].strip
    end
  end
end