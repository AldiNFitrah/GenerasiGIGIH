require 'sinatra'
require 'sinatra/reloader' if development?
require_relative './db/mysql_connector.rb'
require_relative './models/item.rb'
require_relative './models/category.rb'

get '/' do
  items = Item.all()
  return erb(:index, {
    locals: {
      items: items,
    }
  })
end

get '/items/new' do
  categories = Category.all()
  return erb(:create, {
    locals: {
      categories: categories,
    }
  })
end

post '/items/create' do
  item = Item.new(params["name"], params["price"], params['category_id'])
  item.save()

  return redirect('/')
end

get '/items/:id' do
  item = get_item_by_id(params["id"].to_i)
  return erb(:detail, {
    locals: {
      item: item,
    }
  })
end

get '/items/:id/delete' do
  delete_item_by_id(params["id"].to_i)
  return redirect("/")
end

get '/items/:id/edit' do
  categories = get_all_categories()
  item = get_item_by_id(params["id"].to_i)
  return erb(:edit, {
    locals: {
      item: item,
      categories: categories,
    }
  })
end

post '/items/:id/update' do
  update_item_by_id(params["id"], params["name"], params["price"], params["category_id"])
  return redirect("/")
end
