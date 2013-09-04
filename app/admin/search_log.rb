ActiveAdmin.register SearchLog do

  actions :index, :destroy

  index do
    column :query
    column :created_at

    default_actions
  end

end
