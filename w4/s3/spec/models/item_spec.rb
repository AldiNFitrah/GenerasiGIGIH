require './db/mysql_connector.rb'
require './models/item.rb'

describe Item do

  describe '#valid?' do
    context 'given name and price' do
      it 'returns true' do
        item = Item.new({
          name: 'new item',
          price: 1000,
        })

        expected_validity = true
        acutal_validity = item.valid?

        expect(acutal_validity).to(eq(acutal_validity))
      end
    end

    context 'given only name' do
      it 'returns false' do
        item = Item.new({
          name: 'new item',
        })

        expected_validity = false
        acutal_validity = item.valid?

        expect(acutal_validity).to(eq(acutal_validity))
      end
    end

    context 'given only price' do
      it 'returns false' do
        item = Item.new({
          price: 1000,
        })

        expected_validity = false
        acutal_validity = item.valid?

        expect(acutal_validity).to(eq(acutal_validity))
      end
    end

    context 'given nothing' do
      it 'returns false' do
        item = Item.new({})

        expected_validity = false
        acutal_validity = item.valid?

        expect(acutal_validity).to(eq(acutal_validity))
      end
    end

  end
end
