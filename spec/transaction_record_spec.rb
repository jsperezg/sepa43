require 'spec_helper'

describe 'Transaction record' do
  it 'parse' do
    record = Sepa43::TransactionRecord.new('22    1234170101161231990511000000000012340000000000000000000000')
    expect(record.branch_code).to eq('1234')
    expect(record.transaction_date).to eq(Date.parse('2017-01-01'))
    expect(record.value_date).to eq(Date.parse('2016-12-31'))
    expect(record.shared_item).to eq('99')
    expect(record.own_item).to eq('051')
    expect(record.sign.is_debtor?).to be_truthy
    expect(record.amount).to eq(12.34)
    expect(record.document_number).to eq('0000000000')
    expect(record.reference_1).to eq('000000000000')
    expect(record.reference_2).to eq('')
  end
end