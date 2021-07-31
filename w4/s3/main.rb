require 'sinatra'
require 'sinatra/namespace'
require 'sinatra/reloader' if development?
require 'ap'

require './models/item.rb'
require './models/category.rb'
require './controllers/item_controller.rb'
require './controllers/category_controller.rb'


class FoodOmsApp < Sinatra::Base

  register Sinatra::Namespace

  get '/' do
    return erb(
      :index,
      layout: :base
    )
  end

  namespace '/category' do
    get '' do
      data = CategoryController.show_all()
      return erb(
        :"category/list",
        layout: :base,
        locals: data,
      )
    end

    get '/new' do
      return erb(
        :"category/new",
        layout: :base,
      )
    end

    post '/create' do
      CategoryController.create(params)

      return redirect("/category")
    end
    
    get '/:id/delete' do
      CategoryController.delete(params)

      return redirect("/category")
    end

    get '/:id/edit' do
      data = CategoryController.details(params)
      return erb(
        :"category/edit",
        layout: :base,
        locals: data,
      )
    end

    post '/:id/update' do
      data = CategoryController.update(params)
      return redirect("/category")
    end

    get '/:id/item/:item_id/remove' do
      CategoryController.remove_item(params)
      return redirect("/category/#{params["id"]}/edit")
    end

    get '/:id' do
      data = CategoryController.details(params)
      return erb(
        :"category/details",
        layout: :base,
        locals: data
      )
    end
  end

  namespace '/item' do
    get '' do
      data = ItemController.show_all()
      return erb(
        :"item/list",
        layout: :base,
        locals: data,
      )
    end

    get '/new' do
      data = ItemController.new_form()
      
      return erb(
        :"item/new",
        layout: :base,
        locals: data,
      )
    end

    post '/create' do
      ItemController.create(params)

      return redirect("/item")
    end

    get '/:id/delete' do
      ItemController.delete(params)
      
      return redirect("/item")
    end

    get '/:id/edit' do
      data = ItemController.edit(params)
      return erb(
        :"item/edit",
        layout: :base,
        locals: data,
      )
    end

    post '/:id/update' do
      data = ItemController.update(params)
      return redirect("/item")
    end

    get '/:id/category/:category_id/remove' do
      ItemController.remove_category(params)
      return redirect("/item/#{params['id']}/edit")
    end

    get '/:id' do
      data = ItemController.details(params)
      return erb(
        :"item/details",
        layout: :base,
        locals: data
      )
    end
  end

  not_found do
    return erb(
      :page404,
      layout: :base,
    )
  end

  run! if __FILE__ == $0
end
