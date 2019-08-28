class CommentsController < ApplicationController

  before_action :find_project

  def index
    @comment = Comment.new
  end

  def create
    @comment = @project.comments.new(comment_params)
    @comment.author_id = current_user.id
    @comment.save
  end

  private

    def find_project
      @project = Project.find_by(slug: params[:project_slug])
    end

    def comment_params
      params.require(:comment).permit(:body)
    end
end
