ActiveAdmin.register User do     
  index do                            
    column :name
    column :email
    column :created_at
    column :location
  end                                 

  filter :email
  filter :created_at
  filter :location

end                                   
