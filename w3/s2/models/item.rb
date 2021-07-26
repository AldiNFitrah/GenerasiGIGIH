require_relative '../db/mysql_connector'

class Item
  attr_accessor :id, :name, :price, :category

  def initialize(params)
    @name = params[:name]
    @price = params[:price]
  end

  def save
    return false unless valid

    client = create_db_client
    client.query("
      INSERT INTO items(name, price) VALUES
        ('#{name}', '#{price}')
    ")
  end

  def valid
    return false if @name.nil?
    return false if @price.nil?

    return true
  end
end
