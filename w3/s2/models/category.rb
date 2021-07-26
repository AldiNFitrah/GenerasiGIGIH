require_relative '../db/mysql_connector.rb'

class Category
  attr_accessor :name

  def initialize(params)
    @name = params[:name]
  end

  def save()
    if not valid()
      return false
    end

    client = create_db_client()
    client.query("
      INSERT INTO categories(name) VALUES
        ('#{name}')
    ")
  end
  
  def valid()
    return false if @name.nil?

    return true
  end
end
