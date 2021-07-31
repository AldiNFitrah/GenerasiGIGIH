require './db/mysql_connector.rb'
require './models/item.rb'

describe Item do

  client = MySqlClient.instance()

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

  describe '#save' do
    context 'given valid params' do
      it 'should be inserted into database' do
        item = Item.new({
          name: 'new item',
          price: 1,
        })
        item.save()

        all_item = client.query("SELECT * FROM items")

        expected_item_in_db = 1
        actual_item_in_db = all_item.count()

        expect(actual_item_in_db).to(eq(expected_item_in_db))
      end
    end

    context 'given invalid params' do
      it 'should not be inserted into database' do
        item = Item.new({
          name: 'brand new item',
        })
        item.save()

        all_item = client.query("SELECT * FROM items")

        expected_item_in_db = 0
        actual_item_in_db = all_item.count()

        expect(actual_item_in_db).to(eq(expected_item_in_db))
      end
    end
  end

  
end
