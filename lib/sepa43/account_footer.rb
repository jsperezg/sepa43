require 'money'
require 'sepa43/record43'

module Sepa43
  class AccountFooter < Record43
    attr_reader :account, :debit_entries, :total_debit, :credit_entries, :total_credit, :balance_code, :balance, :currency

    def initialize(record)
      super(/\A(\d{2})(\d{4})(\d{4})(\d{10})(\d{5})(\d{14})(\d{5})(\d{14})(\d)(\d{14})(\d{3}).{4}\z/i, record)
    end

    protected

    def validate(parts)
      parts[0] == '33' || raise('Invalid record.')
    end

    def extract_data_from(parts)
      @account = Account.new(bank_code: parts[1],
                             branch_code: parts[2],
                             number: parts[3])

      @debit_entries = parts[4].to_i
      @total_debit = parts[5].to_f / 100

      @credit_entries = parts[6].to_i
      @total_credit = parts[7].to_f / 100

      @balance_code = BalanceCode.new(parts[8])
      @balance = parts[9].to_f / 100

      @currency = Money::Currency.find_by_iso_numeric(parts[10].to_i)
    end
  end
end