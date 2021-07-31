require './db/mysql_connector.rb'

class Category
  attr_accessor :id, :name

  @@client = MySqlClient.instance()

  def initialize(params)
    @id = params[:id]
    @name = params[:name]
    @items = params[:items]
  end

  def save()
    if not self.valid()
      return nil
    end

    if @id.nil?
      @@client.query("
        INSERT INTO categories(name) VALUES
          ('#{@name}')
      ")
      @id = @@client.last_id
    else
      @@client.query("
        UPDATE categories
        SET name = '#{@name}'
        WHERE id = #{@id}
      ")
    end

    return self
  end

  def valid()
    return false if @name.nil?

    return true
  end

  def update(updated_data = [])
    @name = updated_data["name"] || @name
    self.save()
  end

  def items
    if @items.nil?
      @items = Item.get_by_category_id(@id)
    end

    return @items
  end

  def delete()
    @@client.query("
      DELETE FROM categories
      WHERE id = #{@id}
    ")
  end

  def self.get_by_item_id(item_id)
    raw_data = @@client.query("
      SELECT *
      FROM
        categories c
        JOIN item_categories ic
          ON ic.category_id = c.id
      WHERE
        ic.item_id = #{item_id}
    ")

    return convert_sql_to_ruby(raw_data)
  end

  def self.remove_item(id, item_id)
    @@client.query("
      DELETE FROM item_categories ic
      WHERE
        category_id = #{id}
        AND item_id = #{item_id}
    ")
  end

  def self.all()
    raw_data = @@client.query("
      SELECT *
      FROM categories
    ")
    return convert_sql_to_ruby(raw_data)
  end

  def self.get_by_id(id)
    raw_data = @@client.query("
      SELECT *
      FROM categories
      WHERE id = #{id}
    ")

    return convert_sql_to_ruby(raw_data)[0]
  end

  def self.convert_sql_to_ruby(raw_data)
    categories = []
    raw_data.each do |data|
      category = Category.new({
        id: data['id'],
        name: data['name'],
      })
      categories.push(category)
    end

    return categories
  end

  def ==(other)
    return (self.id == other.id && self.name == other.name)
  end
end
