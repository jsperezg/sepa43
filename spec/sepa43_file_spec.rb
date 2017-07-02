require 'spec_helper'

describe 'SEPA 43 File' do
  context 'Loads file' do
    it 'without errors' do
      file = Sepa43::SEPA43File.new("#{Dir.pwd}/spec/fixtures/files/TT210517.666")
      file.load

      expect(file.records).to eq(263)
    end

    it 'Reads all accounts' do
      file = Sepa43::SEPA43File.new("#{Dir.pwd}/spec/fixtures/files/TT210517.666")
      file.load

      expect(file.accounts.length).to eq(1)
      file.accounts.each do |account|
        expect(account.transactions).not_to  be_empty
        expect(account.footer).not_to  be_nil
      end
    end
  end
end