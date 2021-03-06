module Sepa43
  class BalanceCode
    def initialize(code)
      @code = code
    end

    def is_creditor?
      @code == '2'
    end

    def is_debtor?
      @code == '1'
    end
  end
end