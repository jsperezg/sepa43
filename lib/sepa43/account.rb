module Sepa43
  # This class contains the bank account related information.
  class Account
    attr_accessor :bank_code, :branch_code, :number

    def initialize(h)
      h.each { |k, v| public_send("#{k}=", v) }
    end
  end
end