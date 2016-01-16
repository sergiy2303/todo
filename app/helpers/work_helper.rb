module WorkHelper
  def completed_works?
    return true unless current_user.works.where(complete: true).count.zero?
  end
end
