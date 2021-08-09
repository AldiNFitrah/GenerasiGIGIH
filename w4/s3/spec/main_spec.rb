require 'rack/test'
require 'erb'

require './main.rb'
require './models/category.rb'
require './models/item.rb'


describe 'main' do

  include Rack::Test::Methods

  def app
    return FoodOmsApp.new
  end

  describe '/' do
    context 'get /' do
      before(:each) do
        get '/'
      end
      
      it 'should only render template' do
        expect(last_response.body).to(include('Home'))
        expect(last_response.body).to(include('Items'))
        expect(last_response.body).to(include('Categories'))
      end
    end
  end

  describe 'url not found' do
    before(:each) do
      get '/fhicruehdsgjvreksfdivures'
    end

    it 'should render 404 page' do
      expect(last_response.body).to(include('404'))
    end
  end
  
  describe '/category' do
    before(:each) do
      @category1 = Category.new({
        name: "category1",
      })
      @category2 = Category.new({
        name: "category2",
      })

      @category1.save()
      @category2.save()

      @item1 = Item.new({
        name: "item1",
        price: 123123,
      })
      @item2 = Item.new({
        name: "item2",
        price: 234234,
      })

      @item1.save()
      @item2.save()

      @item1.add_category_by_ids([@category1.id])
      @item2.add_category_by_ids([@category2.id])
    end

    describe 'given 2 categories with 1 item connected to each' do

      context 'get /' do
        before(:each) do
          get '/category'
        end

        it "should show the 2 categories' name" do
          expect(last_response.body).to(include(@category1.name))
          expect(last_response.body).to(include(@category2.name))
        end
      end

      context 'get /:id' do
        before(:each) do
          get "/category/#{@category1.id}"
        end

        it "should show category's name and the item name" do
          expect(last_response.body).to(include(@category1.name))
          expect(last_response.body).to(include(@item1.name))
        end
      end

      context 'get /new' do
        before(:each) do
          get '/category/new'
        end

        it "should show a form that will be submitted to /create" do
          expect(last_response.body).to(include('<form'))
          expect(last_response.body).to(include('action="/category/create"'))
        end
      end

      context 'get /:id/edit' do
        before(:each) do
          get "/category/#{@category1.id}/edit"
        end

        it "should show a prefilled form that will be submitted to /:id/update" do
          expect(last_response.body).to(include(@category1.name))

          expect(last_response.body).to(include('<form'))
          expect(last_response.body).to(include("action=\"/category/#{@category1.id}/update\""))
        end
      end

      context 'post /create' do
        before(:each) do
          @new_category_name = "new category"
          post '/category/create', params={"name" => @new_category_name}
        end

        it 'should create new category' do
          expected_num_of_categories = 3
          actual_num_of_categories = Category.all().size()

          expect(actual_num_of_categories).to(eq(actual_num_of_categories))
        end

        it 'should be redirected to /' do
          expect(last_response.redirect?).to(be(true))

          follow_redirect!
          expect(last_request.path).to(eq('/category'))
        end
      end

      context 'get /:id/delete' do
        before(:each) do
          get "/category/#{@category1.id}/delete"
        end

        it "should delete 1 category" do
          expected_num_of_categories = 1
          actual_num_of_categories = Category.all().size()

          expect(actual_num_of_categories).to(eq(actual_num_of_categories))
        end

        it 'should delete the correct category' do
          expected_num_of_categories = [@category2]
          actual_num_of_categories = Category.all()

          expect(actual_num_of_categories).to(match_array(actual_num_of_categories))
        end

        it 'should be redirected to /' do
          expect(last_response.redirect?).to(be(true))

          follow_redirect!
          expect(last_request.path).to(eq('/category'))
        end
      end

      context 'post /:id/update' do
        before(:each) do
          @new_category_name = "udpated category"
          post "/category/#{@category2.id}/update", params={"name" => @new_category_name}
        end

        it 'should be updated' do
          updated_category = Category.get_by_id(@category2.id)

          expected_name = @new_category_name
          actual_name = updated_category.name

          expect(expected_name).to(eq(actual_name))
        end

        it 'should be redirected to /' do
          expect(last_response.redirect?).to(be(true))

          follow_redirect!
          expect(last_request.path).to(eq('/category'))
        end
      end

      context 'post /:id/item/:item_id/remove' do
        before(:each) do
          get(
            "/category/#{@category2.id}/item/#{@item2.id}/remove"
          )
        end

        it 'should remove item' do
          category = Category.get_by_id(@category2.id)

          expected_related_items = []
          actual_related_items = category.items

          expect(actual_related_items).to(match_array(expected_related_items))
        end

        it 'should be redirected to /:id/edit' do
          expect(last_response.redirect?).to(be(true))

          follow_redirect!
          expect(last_request.path).to(eq("/category/#{@category2.id}/edit"))
        end
      end

    end

  end
end
