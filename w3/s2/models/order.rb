require_relative '../db/mysql_connector.rb'

class Order
  attr_accessor :reference_no, :customer_name, :date, :items

  def initialize(params)
    @reference_no = params[:reference_no]
    @customer_name = params[:customer_name]
    @date = params[:date]
  end

  def save()
    if not valid()
      return false
    end

    client = create_db_client()
    client.query("
      INSERT INTO orders(reference_no, customer_name, date) VALUES
        ('#{reference_no}', '#{customer_name}', '#{date}')
    ")
  end

  def valid()
    return false if @reference_no.nil?
    return false if @customer_name.nil?
    return false if @date.nil?

    return true
  end
end
