require 'sepa43/account_header'
require 'sepa43/account_footer'
require 'sepa43/transaction_record'
require 'sepa43/additional_record'
require 'sepa43/end_of_file'

module Sepa43
  class RecordFactory
    def self.instance_for(record)
      result = record.scan( /\A(\d{2})/)
      raise "Invalid record: '#{record}'" if result.empty?

      record_code = result.first[0]

      if record_code == '11'
        return AccountHeader.new(record)
      end

      if record_code == '22'
        return TransactionRecord.new(record)
      end

      if record_code == '23'
        return AdditionalRecord.new(record)
      end

      if record_code == '33'
        return AccountFooter.new(record)
      end

      if record_code == '88'
        return EndOfFile.new(record)
      end

      raise 'Unknown record code'
    end
  end
end