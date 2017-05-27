require 'spec_helper'

describe 'End of file' do
  it 'parses record' do
    record = Sepa43::EndOfFile.new('88999999999999999999000262                                                      ')
    expect(record.records).to eq(262)
  end
end