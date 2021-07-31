require './db/mysql_connector.rb'
require './models/category.rb'
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

  describe '#update' do
    context 'given new name' do
      before(:each) do
        @item = item = Item.new({
          name: 'new item',
          price: 1,
        })
        @item.save()

        @new_item_name = 'kinder joy'
        @item.update(updated_data = {
          name: @new_item_name,
        })
      end

      it 'should update the instance name' do
        expected_item_name = @new_item_name
        actual_item_name = @item.name

        expect(actual_item_name).to(eq(expected_item_name))
      end

      it 'should update the name in database' do
        result = client.query("
          SELECT *
          FROM items
          WHERE id = #{@item.id}
        ")

        item_data = result.first

        expected_item_name = @new_item_name
        actual_item_name = item_data["name"]

        expect(actual_item_name).to(eq(expected_item_name))
      end
    end
  end

  describe '#delete' do
    before(:each) do
      @item = Item.new({
        name: "item for #delete",
        price: 243,
      })
      @item.save()
    end

    it 'should success' do
      @item.delete()

      all_item = client.query("SELECT * FROM items")

      expected_item_in_db = 0
      actual_item_in_db = all_item.count()

      expect(actual_item_in_db).to(eq(expected_item_in_db))
    end
  end

  describe '#categories' do
    before(:each) do
      @item = Item.new({
        name: "item for #categories",
        price: 1213,
      })
      @item.save()
    end

    context 'given no categories' do
      it 'should return empty array' do
        expected_categories = []
        actual_categories = @item.categories()

        expect(actual_categories).to(match_array(expected_categories))
      end
    end

    context 'given 2 categories' do
      before(:each) do
        @category1 = Category.new({
          name: "cat1",
        })
        @category2 = Category.new({
          name: "cat2",
        })

        @category1.save()
        @category2.save()

        @item.add_category_by_ids([@category1.id, @category2.id])
      end

      it 'should contain 2 categories' do
        expected_categories = [@category1, @category2]
        actual_categories = @item.categories()

        expect(actual_categories).to(match_array(expected_categories))
      end

      it '#category_ids should contain 2 categories' do
        expected_category_ids = [@category1.id, @category2.id]
        actual_category_ids = @item.category_ids()

        expect(expected_category_ids).to(match_array(actual_category_ids))
      end
    end
  end

  describe '#add_category_by_ids' do
    before(:each) do
      @item = Item.new({
        name: "item for #categories",
        price: 1213,
      })
      @item.save()
    end

    context 'given 1 id' do
      before(:each) do
        @category = Category.new({
          name: "cat1",
        })

        @category.save()

        @item.add_category_by_ids([@category.id])
      end

      it 'should be connected to 1 category' do
        result = client.query("
          SELECT *
          FROM item_categories
          WHERE
            item_id = #{@item.id}
        ")

        expected_num_of_categories = 1
        actual_num_of_categories = result.count()

        expect(actual_num_of_categories).to(eq(expected_num_of_categories))
      end
    end

    context 'given 0 id' do
      before(:each) do
        @item.add_category_by_ids([])
      end

      it 'should be connected to 0 category' do
        result = client.query("
          SELECT *
          FROM item_categories
          WHERE
            item_id = #{@item.id}
        ")

        expected_num_of_categories = 0
        actual_num_of_categories = result.count()

        expect(actual_num_of_categories).to(eq(expected_num_of_categories))
      end
    end
  end

  describe '#remove_category_by_ids' do
    before(:each) do
      @item = Item.new({
        name: "item for #categories",
        price: 1213,
      })
      @item.save()

      @category = Category.new({
        name: "cat1",
      })

      @category.save()

      @item.add_category_by_ids([@category.id])
    end

    context 'remove 0 category' do
      before(:each) do
        @item.remove_category_by_ids([])
      end
      
      it 'should still be connected to 1 category' do
        result = client.query("
          SELECT *
          FROM item_categories
          WHERE
            item_id = #{@item.id}
        ")

        expected_num_of_categories = 1
        actual_num_of_categories = result.count()

        expect(actual_num_of_categories).to(eq(expected_num_of_categories))
      end
    end

    context 'remove 1 category' do
      before(:each) do
        @item.remove_category_by_ids([@category.id])
      end

      it 'should be connected to 0 category' do
        result = client.query("
          SELECT *
          FROM item_categories
          WHERE
            item_id = #{@item.id}
        ")

        expected_num_of_categories = 0
        actual_num_of_categories = result.count()

        expect(actual_num_of_categories).to(eq(expected_num_of_categories))
      end
    end
  end

  describe '.all' do
    context 'given 0 items in database' do
      it 'should return 0 items' do
        result = client.query("
          SELECT *
          FROM items
        ")

        expected_num_of_items = 0
        actual_num_of_items = result.count()

        expect(actual_num_of_items).to(eq(expected_num_of_items))
      end
    end

    context 'given 2 items in database' do
      before(:each) do
        client.query("
          INSERT INTO items(name, price) VALUES
            ('item1', 123),
            ('item2', 321)
        ")
      end

      it 'should return 2 items' do
        result = client.query("
          SELECT *
          FROM items
        ")

        expected_num_of_items = 2
        actual_num_of_items = result.count()

        expect(actual_num_of_items).to(eq(expected_num_of_items))
      end
    end
  end
end
