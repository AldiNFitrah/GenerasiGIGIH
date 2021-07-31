require 'mysql2'
require 'dotenv'
Dotenv.load
class MySqlClient
  
  def self.instance()
    if @instance.nil?
      @instance = get_client()
    end

    return @instance
  end
  
  def self.get_client()
    @instance = Mysql2::Client.new(
      host: ENV['DB_HOST'],
      username: ENV['DB_USERNAME'],
      password: ENV['DB_PASSWORD'],
      database: ENV['DB_NAME'],
    )
  end

  private_class_method :get_client, :new
end
