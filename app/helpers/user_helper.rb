module UserHelper

  def own_profile?
    current_user.try(:id) == @user.id
  end

end