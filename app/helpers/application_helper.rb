module ApplicationHelper
  
  def already_voted?
    range = Date.today.beginning_of_day..Date.today.end_of_day
    Vote.find_by(vote_id: current_user.id, created_at: range).present?
  end
end
