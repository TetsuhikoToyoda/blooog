class BlogsController < ApplicationController

   before_action :move_to_index, except: :index

  def index
    @blogs = Blog.all
  end

  def new
    @blog = Blog.new
  end

  def create
    Blog.create(image: blog_params[:image], text: blog_params[:text], user_id: current_user.id)
    redirect_to controller: :blogs, action: :index
  end

  def destroy
    blog = Blog.find(params[:id])
    blog.destroy if blog.user_id == current_user.id
  end

  def edit
    @blog = Blog.find(params[:id])
  end

  def update
    @blog = Blog.find(params[:id])
    @blog.update(image: blog_params[:image], text: blog_params[:text], user_id: current_user.id)
    redirect_to controller: :blogs, action: :index
  end

  private
  def blog_params
    params.require(:blog).permit(:text, :image)
  end

  def move_to_index
    redirect_to action: :index unless user_signed_in?
  end
end
