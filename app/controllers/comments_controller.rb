class CommentsController < ApplicationController

  find :project, :slug

  before_action :find_project

  before_action :authenticate_user!

  def index
    @comment = Comment.new
  end

  def create
    @comment = @project.comments.new(comment_params)
    @comment.author_id = current_user.id
    @comment.save
  end

  private

    def comment_params
      params.require(:comment).permit(:body)
    end
end
