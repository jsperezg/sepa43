require 'date'
require 'sepa43/account'

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

  HEADER_KEYS = {
    debtor: 1,
    creditor: 2
  }.freeze

  # Account header record.
  class AccountHeader
    attr_reader :account, :start_date, :end_date, :key, :balance, :currency, :name

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

      # => ["11", "2100", "7677", "2200006857", "170101", "170331", "2", "00000000240844", "978", "3", "JUAN SALVADOR PEREZ GARCIA"]
    end

    def validate(parts)
      parts[0] == '11' || raise('Invalid record.')
      parts[9] == '3' || raise('Invalid mode. Only mode 3 is supported.')
    end

    def extract_data_from(parts)
      @account = Account.new(bank_code: parts[1],
                             branch_code: parts[2],
                             account: parts[3])
      @start_date = Date.parse(parts[4])
      @end_date = Date.parse(parts[5])
      @key = parts[6].to_i
      @balance = parts[7].to_f / 100.0
      @currency = parts[8]
      @name = parts[10].strip
    end
  end
end