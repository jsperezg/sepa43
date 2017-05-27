require 'spec_helper'

describe 'Begin of file' do
  it 'parses record' do
    record = Sepa43::BeginOfFile.new('001234170527                                                                    ')
    expect(record.bank_code).to eq('1234')
    expect(record.accounting_date).to eq(Date.parse('2017-05-27'))
  end
end