module Admin
  class CommentsController < TimeTracker::CommentsController
    include Administrated
  end
end
