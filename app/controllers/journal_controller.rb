class JournalController < ApplicationController

  before_action :authenticate_user!

  def index
    @journal = TimeLog.for_author_user(current_user)
                   .paginate(page: params[:page], per_page: 20)
  end
end
