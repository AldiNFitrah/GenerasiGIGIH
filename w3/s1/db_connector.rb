require_relative './models/item'
require_relative './models/category'
require 'mysql2'

def create_db_client
  client = Mysql2::Client.new(
    :host => "localhost",
    :username => "root",
    :password => "root",
    :database => "food_oms_db",
  )
  return client
end

def get_all_items
  client = create_db_client
  raw_data = client.query("SELECT * FROM items")

  items = []
  raw_data.each do |data|
    item = Item.new(data["id"], data["name"], data["price"])
    items.push(item)
  end

  return items
end

def get_all_items_with_category
  client = create_db_client
  raw_data = client.query("
    SELECT
      i.id AS item_id,
      i.name,
      i.price,
      c.name AS c_name,
      c.id AS c_id
    from
      items i
      LEFT JOIN item_categories ic
        ON i.id = ic.item_id
      LEFT JOIN categories c
        ON c.id = ic.category_id
  ")

  raw_data.each do |data|
    category = Category.new(data['c_id'], data['c_name'])
    item = Item.new(data['item_id'], data['name'], data['price'], category)
    items.push(item)
  end

  return items
end

def get_all_items_cheaper_than(price)
  client = create_db_client
  raw_data = client.query("
    SELECT *
    FROM items i
    WHERE price < #{price}
  ")

  items = []
  raw_data.each do |data|
    item = Item.new(data['id'], data['name'], data['price'])
    items.push(item)
  end

  items
end

def get_item_by_id(id)
  client = create_db_client
  raw_data = client.query("
    SELECT
      i.id,
      i.name,
      i.price,
      c.id AS c_id,
      c.name AS c_name
    FROM items i
      LEFT JOIN item_categories ic
        ON i.id = ic.item_id
      LEFT JOIN categories c
        ON c.id = ic.category_id
    WHERE i.id = #{id}")

  if raw_data.count == 0
    return nil
  else
    data = raw_data.to_a[0]
  end

  category = Category.new(data['c_id'], data['c_name'])
  item = Item.new(data['id'], data['name'], data['price'], category)

  return item
end

def create_new_item(name, price, category_id)
  client = create_db_client
  client.query("
    INSERT INTO items (name, price)
    VALUES('#{name}', '#{price}')
  ")

  raw_data = client.query("
    SELECT * FROM items ORDER BY id DESC LIMIT 1
  ")

  if raw_data.count == 0
    return nil
  else
    data = raw_data.to_a[0]
    item = Item.new(data['id'], data['name'], data['price'])
  end

  client.query("
    INSERT INTO item_categories (item_id, category_id)
    VALUES(#{item.id}, #{category_id})
  ")
end

def get_all_categories()
  client = create_db_client
  raw_data = client.query('SELECT * FROM categories')

  categories = []
  raw_data.each do |data|
    category = Category.new(data['id'], data['name'])
    categories.push(category)
  end

  return categories
end

def get_category_by_id(id)
  client = create_db_client
  raw_data = client.query("
    SELECT *
    FROM categories
    WHERE id = #{id}
  ")

  if raw_data.count == 0
    return nil
  else
    data = raw_data.to_a[0]
  end

  category = Category.new(data['id'], data['name'])
  return category
end

def update_item_by_id(id, name, price, category_id)
  client = create_db_client
  category = get_category_by_id(category_id)

  raw_data = client.query("
    SELECT *
    FROM item_categories ic
    WHERE
      item_id = #{id}
      AND category_id = #{category_id}
  ")

  if raw_data.count == 0
    return nil
  else
    item_category = raw_data.to_a[0]
  end

  client.query("
    UPDATE item_categories ic
    SET category_id = #{category_id}
    WHERE
      item_id = #{id}
      AND category_id = #{category_id}
  ")

  client.query("
    UPDATE items
    SET
      name = '#{name}',
      price = #{price}
    WHERE
      id = #{id}
  ")
end

def delete_item_by_id(id)
  client = create_db_client
  client.query("
    DELETE FROM items
    WHERE id = #{id}
  ")
end
