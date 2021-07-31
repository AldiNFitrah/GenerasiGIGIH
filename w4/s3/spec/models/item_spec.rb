require './db/mysql_connector.rb'
require './models/item.rb'

describe Item do
  describe 'dummy' do
    it 'returns true' do
      expect(true).to(eq(true))
    end
  end
end