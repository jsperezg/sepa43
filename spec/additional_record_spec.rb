require 'spec_helper'

describe 'Additional record' do
  it 'parse' do
    record = Sepa43::AdditionalRecord.new('2301                                      ADDITIONAL RECORD                     ')
    expect(record.data_code).to eq('01')
    expect(record.first_item).to eq('')
    expect(record.second_item).to eq('ADDITIONAL RECORD')
  end
end