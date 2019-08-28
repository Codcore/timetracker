module Administrated

  extend ActiveSupport::Concern

  included do
    layout 'admin'

    before_action :authenticate_user!
    before_action :authenticate_admin!
  end

  def authenticate_admin!
    redirect_to root_path, alert: "You\'re not authorized to access this page" unless current_user.admin?
  end
end