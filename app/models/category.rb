class Category < ActiveRecord::Base
  attr_accessible :order_num, :title, :sub_categories_attributes

  has_many :sub_categories, dependent: :destroy, autosave: true

  default_scope order(:order_num)

  accepts_nested_attributes_for :sub_categories, allow_destroy: true

end
