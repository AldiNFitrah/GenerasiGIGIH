require './models/category'
require './models/item'

class ItemController
  def self.create(params)
    item = Item.new({
      name: params['name'],
      price: params['price'],
    })
    item.save()

    category_ids = (params['category_ids'] || []).reject(&:empty?).map(&:to_i)
    item.add_category_by_ids(category_ids)
  end

  def self.delete(params)
    item = Item.get_by_id(params["id"])
    item.delete()
  end

  def self.details(params)
    item = Item.get_by_id(params["id"])
    return { item: item }
  end

  def self.edit(params)
    item = Item.get_by_id(params["id"])
    categories = Category.all()
    return { item: item, categories: categories }
  end

  def self.update(params)
    item = Item.get_by_id(params["id"])
    item.update(params)

    old_category_ids = item.category_ids
    new_category_ids = (params['category_ids'] || []).reject(&:empty?).map(&:to_i)
    
    deleted_category_ids = []
    added_category_ids = []

    old_category_ids.each do |old_category_id|
      if !new_category_ids.include?(old_category_id)
        deleted_category_ids.push(old_category_id)
      end
    end

    new_category_ids.each do |new_category_id|
      if !old_category_ids.include?(new_category_id)
        added_category_ids.push(new_category_id)
      end
    end

    item.remove_category_by_ids(old_category_ids)
    item.add_category_by_ids(new_category_ids)
  end

  def self.show_all()
    return { items: Item.all() }
  end

  def self.new_form()
    return { categories: Category.all() }
  end
end
