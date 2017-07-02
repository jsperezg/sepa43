require 'sepa43/record_factory'
require 'aasm'

module Sepa43
  class SEPA43File
    attr_reader :records, :accounts

    include AASM

    aasm do
      state :account_header, initial: true
      state :transaction_record, :additional_record, :account_footer, :end_of_file

      before_all_events :read_next_record

      event :next do
        transitions from: :account_header, to: :transaction_record

        transitions from: :transaction_record, to: :additional_record, guard: :next_is_additional_record?
        transitions from: :transaction_record, to: :transaction_record, guard: :next_is_transaction_record?
        transitions from: :transaction_record, to: :account_footer, guard: :next_is_account_footer?

        transitions from: :additional_record, to: :additional_record, guard: :next_is_additional_record?
        transitions from: :additional_record, to: :transaction_record, guard: :next_is_transaction_record?
        transitions from: :additional_record, to: :account_footer, guard: :next_is_account_footer?

        transitions from: :account_footer, to: :account_header, guard: :next_is_account_header?
        transitions from: :account_footer, to: :end_of_file, guard: :next_is_end_of_file?
      end
    end


    def initialize(file_name)
      @content = File.readlines(file_name, encoding: 'ISO-8859-15')
      @next = nil
      @index = 0
      @records = 0
      @accounts = []
    end

    def load
      account  = nil
      transaction = nil

      while has_more_records? do
        @records += 1

        account  = @next if next_is_account_header?

        if next_is_transaction_record?
          account.transactions << transaction unless transaction.nil?
          transaction = @next
        end

        if next_is_additional_record?
          transaction.additional << @next
        end

        if next_is_account_footer?
          account.transactions << transaction unless transaction.nil?
          transaction = nil

          account.footer  = @next
          @accounts << account
          account = nil
        end

        self.next
      end
    end

    private

    def has_more_records?
      @index < @content.length && !@content[@index].chomp != ''
    end

    def read_next_record
      @next = RecordFactory.instance_for(@content[@index].chomp)
      @index += 1
    end

    def next_is_additional_record?
      @next.is_a? AdditionalRecord
    end

    def next_is_transaction_record?
      @next.is_a? TransactionRecord
    end

    def next_is_account_footer?
      @next.is_a? AccountFooter
    end

    def next_is_account_header?
      @next.is_a? AccountHeader
    end

    def next_is_end_of_file?
      @next.is_a? EndOfFile
    end
  end
end