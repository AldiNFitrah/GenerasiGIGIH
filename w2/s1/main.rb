require 'sinatra'
require "sinatra/reloader" if development?

items = []

get '/item' do
  return erb(:item, {locals: {
    items: items,
  }})
end

post '/item' do
  if params["item_name"]
    items.push(params["item_name"])
  end

  return redirect('/item')
end
