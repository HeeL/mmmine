class SubCategory < ActiveRecord::Base

  attr_accessible :title

  belongs_to :category

  default_scope order(:title)


  def for_select
    self.collect { |c| [c.title, c.id] }
  end

end
