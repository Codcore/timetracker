class CommentsController < ApplicationController

  before_action :find_commentable

  before_action :authenticate_user!

  def index
    @comment = Comment.new
  end

  def create
    @comment = @commentable.comments.new(comment_params)
    @comment.author_id = current_user.id
    @comment.save
  end

  private

    def comment_params
      params.require(:comment).permit(:body)
    end

    def find_commentable
      @commentable = params[:project_slug].present? ? Project.find_by(slug: params[:project_slug]) : Task.find(params[:task_id])
    end
end
