require 'spec_helper'

describe 'Account footer' do
  it 'parses record' do
    record = Sepa43::AccountFooter.new('3312345678123456789000086000000012345670001200000001234567200000000123456978    ')

    expect(record.account).not_to be_nil
    expect(record.account.bank_code).to eq('1234')
    expect(record.account.branch_code).to eq('5678')
    expect(record.account.number).to eq('1234567890')

    expect(record.debit_entries).to eq(86)
    expect(record.total_debit).to eq(12345.67)

    expect(record.credit_entries).to eq(12)
    expect(record.total_credit).to eq(12345.67)

    expect(record.balance).to eq(1234.56)
    expect(record.balance_code.is_creditor?).to be_truthy

    expect(record.currency.name).to eq('Euro')
  end
end