require 'date'
require 'sepa43/sign_code'

module Sepa43
  class TransactionRecord
    attr_reader :branch_code, :transaction_date, :value_date, :shared_item, :own_item, :sign, :amount, :document_number,
                :reference_1, :reference_2

    def initialize(record)
      parse(record)
    end

    private

    def parse(record)
      result = record.scan(/\A(\d{2}).{4}(\d{4})(\d{6})(\d{6})(\d{2})(\d{3})(\d)(\d{14})(\d{10})(\d{12})(.{0,16})\z/i)
      raise 'Invalid record.' if result.empty?

      parts = result.first
      validate(parts)
      extract_data_from(parts)
    end

    def validate(parts)
      parts[0] == '22' || raise('Invalid record.')
    end

    def extract_data_from(parts)
      @branch_code = parts[1]
      @transaction_date = Date.parse(parts[2])
      @value_date = Date.parse(parts[3])
      @shared_item = parts[4]
      @own_item = parts[5]
      @sign = Sepa43::SignCode.new(parts[6])
      @amount = parts[7].to_f / 100.0
      @document_number = parts[8]
      @reference_1 = parts[9]
      @reference_2 = parts[10]
    end
  end
end