module Admin
  class CommentsController < TimeTracker::CommentsController
    layout 'admin'

    before_action :authenticate_user!
    before_action :authenticate_admin!

    def authenticate_admin!
      redirect_to root_path, alert: "You\'re not authorized to access this page" unless current_user.admin?
    end
  end
end
