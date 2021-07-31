require './controllers/category_controller.rb'
require './models/category.rb'

describe CategoryController do

  controller = CategoryController

  describe '.create' do
    context 'given params' do
      before(:each) do
        controller.create({
          'name'=> 'new cat',
        })
      end

      it 'should be inserted into database' do
        all_category = Category.all()

        expected_num_of_category = 1
        actual_num_of_category = all_category.size()

        expect(actual_num_of_category).to(eq(expected_num_of_category))
      end
    end

    context 'given nothing' do
      before(:each) do
        controller.create({})
      end

      it 'should insert nothing into database' do
        all_category = Category.all()

        expected_num_of_category = 0
        actual_num_of_category = all_category.size()

        expect(actual_num_of_category).to(eq(expected_num_of_category))
      end
    end
  end

  describe '.delete' do
    before(:each) do
      category = Category.new({
        name: 'new cat',
      })
      category.save()

      @category_id = category.id
    end

    context 'given valid id' do
      before(:each) do
        controller.delete({
          'id'=> @category_id,
        })
      end

      it 'should be deleted from database' do
        all_category = Category.all()

        expected_num_of_category = 0
        actual_num_of_category = all_category.size()

        expect(actual_num_of_category).to(eq(expected_num_of_category))
      end
    end

    context 'given invalid id' do
      before(:each) do
        controller.delete({
          'id'=> -123,
        })
      end

      it 'should do nothing in database' do
        all_category = Category.all()

        expected_num_of_category = 1
        actual_num_of_category = all_category.size()

        expect(actual_num_of_category).to(eq(expected_num_of_category))
      end
    end
  end

  describe '.show_all' do
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
      end

      it 'should return 2 categories inside hash' do
        expected_return_value = {categories: [@category1, @category2]}
        actual_return_value = controller.show_all()

        expect(actual_return_value).to(eq(expected_return_value))
      end
    end

    context 'given 0 categories' do
      it 'should return 0 categories inside hash' do
        expected_return_value = {categories: []}
        actual_return_value = controller.show_all()

        expect(actual_return_value).to(eq(expected_return_value))
      end
    end
  end

  describe '.details' do
    context 'given a category' do
      before(:each) do
        @category = Category.new({
          name: "cat1",
        })

        @category.save()
      end

      it 'should return the correct cateogry' do
        expected_return_value = {category: @category}
        actual_return_value = controller.details({
          "id" => @category.id,
        })

        expect(actual_return_value).to(eq(expected_return_value))
      end
    end

    context 'given 0 categories' do
      it 'should return nil inside hash' do
        expected_return_value = {category: nil}
        actual_return_value = controller.details({
          "id" => -213
        })

        expect(actual_return_value).to(eq(expected_return_value))
      end
    end
  end

  describe '.update' do
    before(:each) do
      @category = Category.new({
        name: "cat1",
      })

      @category.save()
    end

    context 'given valid id and new name' do
      before(:each) do
        @new_name = "brand new name"

        controller.update({
          "id" => @category.id,
          "name" => @new_name
        })
      end

      it 'should be updated' do
        category = Category.get_by_id(@category.id)

        expected_category_name = @new_name
        actual_category_name = category.name

        expect(actual_category_name).to(eq(expected_category_name))
      end
    end

    context 'given wrong id and new name' do
      before(:each) do
        @new_name = "brand new name"

        controller.update({
          "id" => -213,
          "name" => @new_name
        })
      end

      it 'should not be updated' do
        category = Category.get_by_id(@category.id)

        expected_category_name = @category.name
        actual_category_name = category.name

        expect(actual_category_name).to(eq(expected_category_name))
      end
    end
  end
end
