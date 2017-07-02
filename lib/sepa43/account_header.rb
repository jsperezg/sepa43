require 'date'

require 'money'

require 'sepa43/account'
require 'sepa43/balance_code'
require 'sepa43/record43'


module Sepa43
  # Account header record.
  class AccountHeader < Record43
    attr_reader :account, :start_date, :end_date, :balance_code, :balance, :currency, :name
    attr_accessor :footer, :transactions

    def initialize(record)
      super(/\A(\d{2})(\d{4})(\d{4})(\d{10})(\d{6})(\d{6})(\d)(\d{14})(\d{3})(\d)(.{26}).{3}\z/i, record)

      @footer = nil
      @transactions = []
    end

    protected

    def validate(parts)
      parts[0] == '11' || raise('Invalid record.')
    end

    def extract_data_from(parts)
      @account = Account.new(bank_code: parts[1],
                             branch_code: parts[2],
                             number: parts[3])
      @start_date = Date.parse(parts[4])
      @end_date = Date.parse(parts[5])
      @balance_code = BalanceCode.new(parts[6])
      @balance = parts[7].to_f / 100.0
      @currency = Money::Currency.find_by_iso_numeric(parts[8].to_i)
      @name = parts[10].strip
    end
  end
end