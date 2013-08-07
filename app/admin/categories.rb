ActiveAdmin.register Category do

  index do
    column :title
    column :order_num

    default_actions
  end

  form do |f|
    f.inputs do
      f.input :title
      f.input :order_num
    end

    f.has_many :sub_categories do |f|
      f.input :title
    end

    f.actions
  end

  show do |category|
    attributes_table do
      row 'Category' do |cat|
        cat.title
      end

      table_for category.sub_categories do
        column 'Sub Categories' do |sub_cat|
          sub_cat.title
        end
      end

    end
  end

end
