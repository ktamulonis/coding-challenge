class CommentsController < ApplicationController
  before_action :set_post
  before_action :set_comment, only: [:edit, :update, :destroy]

  def create
    comment = @post.comments.create! comments_params

    redirect_to @post
  end

  def edit
  end 

  def update
    @comment.update(comments_params) 
    
    redirect_to @post
  end 


  def destroy
    @comment.destroy

    redirect_to @post
  end
  
  private
  
    def set_post
      @post = Post.find(params[:post_id]) 
    end 

    def set_comment
      @comment = Comment.find(params[:id])
    end
  
    def comments_params
      params.required(:comment).permit(:body, :post_id)
    end
end
