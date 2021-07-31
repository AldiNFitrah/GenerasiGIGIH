require './controllers/category_controller.rb'
require './models/category.rb'

describe CategoryController do

  before(:all) do
    @controller = CategoryController
  end

  describe '.create' do
    context 'given params' do
      before(:each) do
        @controller.create({
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
        @controller.create({})
      end

      it 'should insert nothing into database' do
        all_category = Category.all()

        expected_num_of_category = 0
        actual_num_of_category = all_category.size()

        expect(actual_num_of_category).to(eq(expected_num_of_category))
      end
    end
  end

end
