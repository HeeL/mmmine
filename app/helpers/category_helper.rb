module CategoryHelper

  def subs_for_select
    [['Please choose...', '']] + @subs.map{|s| [s.title, s.id]}
  end
  
end