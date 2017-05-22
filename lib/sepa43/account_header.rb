require 'date'
require 'sepa43/account'
require 'sepa43/sign_code'

module Sepa43
  CURRENCIES = {
    australian_dollar: '036',
    canadian_dollar: '124',
    danish_crown: '208',
    japanese_yen: '392',
    new_zealand_dollar: '554',
    norwegian_crown: '578',
    swedish_crown: '752',
    swiss_franc: '756',
    sterling_pound: '826',
    us_dollar: '840',
    euro: '978'
  }.freeze

  # Account header record.
  class AccountHeader
    attr_reader :account, :start_date, :end_date, :sign, :balance, :currency, :name

    def initialize(record)
      parse(record)
    end

    private

    def parse(record)
      result = record.scan(/\A(\d{2})(\d{4})(\d{4})(\d{10})(\d{6})(\d{6})(\d)(\d{14})(\d{3})(\d)(.{26}).{0,3}\z/i)
      raise 'Invalid record.' if result.empty?

      parts = result.first
      validate(parts)
      extract_data_from(parts)
    end

    def validate(parts)
      parts[0] == '11' || raise('Invalid record.')
    end

    def extract_data_from(parts)
      @account = Account.new(bank_code: parts[1],
                             branch_code: parts[2],
                             number: parts[3])
      @start_date = Date.parse(parts[4])
      @end_date = Date.parse(parts[5])
      @sign = Sepa43::SignCode.new(parts[6])
      @balance = parts[7].to_f / 100.0
      @currency = parts[8]
      @name = parts[10].strip
    end
  end
end