require 'spec_helper'

describe 'Record parse' do
  it 'parses record' do
    record = Sepa43::AccountHeader.new('111234567812345678901701011703312000000001234569783POBRECITO HABLADOR        ')

    expect(record.account).not_to be_nil
    expect(record.account.bank_code).to eq('1234')
    expect(record.account.branch_code).to eq('5678')
    expect(record.account.account).to eq('1234567890')

    expect(record.start_date).to eq(Date.parse('2017-01-01'))
    expect(record.end_date).to eq(Date.parse('2017-03-31'))

    expect(record.key).to eq(Sepa43::HEADER_KEYS[:creditor])
    expect(record.balance).to eq(1234.56)
    expect(record.currency).to eq(Sepa43::CURRENCIES[:euro])

    expect(record.name).to eq('POBRECITO HABLADOR')
  end
end