require './models/category'

class CategoryController
  def self.create(params)
    category = Category.new({
      name: params['name']
    })
    category.save()
  end

  def self.delete(params)
    category = Category.get_by_id(params["id"])
    category.delete()
  end

  def self.show_all()
    return { categories: Category.all() }
  end

  def self.details(params)
    category = Category.get_by_id(params["id"])
    return { category: category }
  end

  def self.update(params)
    category = Category.get_by_id(params["id"])
    category.update(params)
  end
  
  def self.remove_item(params)
    Category.remove_item(params["id"], params["item_id"])
  end
end
