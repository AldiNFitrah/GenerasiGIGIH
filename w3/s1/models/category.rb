class Category
  attr_accessor :id, :name

  def initialize(id, name)
    @id = id
    @name = name
  end

  def to_s
    return "#{@name}"
  end
end
