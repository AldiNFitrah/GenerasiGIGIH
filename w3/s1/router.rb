require 'sinatra'
require 'sinatra/reloader' if development?
require_relative "./db_connector.rb"

get '/' do
  items = get_all_items()
  return erb(:index, {
    locals: {
      items: items,
    }
  })
end

get '/items/new' do
  return erb(:create)
end

post '/items/create' do
  create_new_item(params["name"], params["price"])
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
  item = get_item_by_id(params["id"].to_i)
  return erb(:edit, {
    locals: {
      item: item,
    }
  })
end

get '/items/:id/update' do
  update_item_by_id(params["id"], params["name"], params["price"], params["category_id"])
  return redirect("/")
end
