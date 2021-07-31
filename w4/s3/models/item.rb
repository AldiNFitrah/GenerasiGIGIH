require './db/mysql_connector'

class Item
  attr_reader :id
  attr_accessor :name, :price

  @@client = MySqlClient.instance()

  def initialize(params)
    @id = params[:id]
    @name = params[:name]
    @price = params[:price]
    @categories = params[:categories]
  end

  def save()
    return false unless valid?()

    if @id.nil?
      @@client.query("
        INSERT INTO items(name, price) VALUES
          ('#{name}', '#{price}')
      ")
      @id = @@client.last_id
    else
      @@client.query("
        UPDATE items
        SET
          name = '#{@name}',
          price = '#{@price}'
        WHERE id = #{@id}
      ")
    end

    return self
  end

  def valid?()
    return false if @name.nil?
    return false if @price.nil?

    return true
  end

  def update(updated_data = [])
    @name = updated_data[:name] || @name
    @price = updated_data[:price] || @price
    self.save()
  end

  def categories()
    if @categories.nil?
      @categories = Category.get_by_item_id(@id)
    end

    return @categories
  end

  def category_ids()
    return self.categories.map(&:id)
  end

  def delete()
    @@client.query("
      DELETE FROM items
      WHERE id = #{@id}  
    ")
  end

  def add_category_by_ids(category_ids = [])
    if category_ids.to_a.empty?
      return
    end

    string_values = category_ids.map{
      |category_id| "(#{@id}, #{category_id})"
    }

    @@client.query("
      INSERT INTO item_categories(item_id, category_id) VALUES
        #{string_values.join(', ')}
    ")
  end

  def remove_category_by_ids(category_ids = [])
    if category_ids.to_a.empty?
      return
    end

    @@client.query("
      DELETE FROM item_categories
      WHERE
        item_id = #{@id}
        AND category_id IN (#{category_ids.join(', ')})
    ")
  end

  def self.all()
    raw_data = @@client.query("
      SELECT *
      FROM items
    ")
    return convert_sql_to_ruby(raw_data)
  end

  def self.get_by_id(id)
    raw_data = @@client.query("
      SELECT *
      FROM items
      WHERE id = #{id}
    ")

    return convert_sql_to_ruby(raw_data)[0]
  end

  def self.get_by_category_id(category_id)
    raw_data = @@client.query("
      SELECT *
      FROM
        items i
        JOIN item_categories ic
          ON ic.item_id = i.id
      WHERE
        ic.category_id = #{category_id}
    ")

    return convert_sql_to_ruby(raw_data)
  end

  def self.convert_sql_to_ruby(raw_data)
    items = []
    raw_data.each do |data|
      item = Item.new({
        id: data['id'],
        name: data['name'],
        price: data['price'],
      })
      items.push(item)
    end

    return items
  end
end
