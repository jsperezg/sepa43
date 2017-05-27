require 'spec_helper'

describe 'Account header' do
  it 'parses record' do
    record = Sepa43::AccountHeader.new('111234567812345678901701011703312000000001234569783POBRECITO HABLADOR           ')

    expect(record.account).not_to be_nil
    expect(record.account.bank_code).to eq('1234')
    expect(record.account.branch_code).to eq('5678')
    expect(record.account.number).to eq('1234567890')

    expect(record.start_date).to eq(Date.parse('2017-01-01'))
    expect(record.end_date).to eq(Date.parse('2017-03-31'))

    expect(record.balance_code.is_creditor?).to be_truthy
    expect(record.balance).to eq(1234.56)
    expect(record.currency.name).to eq('Euro')

    expect(record.name).to eq('POBRECITO HABLADOR')
  end
end