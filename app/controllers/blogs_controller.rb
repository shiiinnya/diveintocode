class BlogsController < ApplicationController

    before_action :user_signed, only: [:show, :index, :new, :create, :edit, :update, :destroy]
    
    
    def index
       @blog = Blog.paginate(page:params[:page])
    end
    def new
        @blog = Blog.new
    end
    def create
       @blog = current_user.blogs.build(params_create)
     if @blog.save
        redirect_to "/blogs"
     else
        render "new"
     end
    end
    def show
       @blog = Blog.find params[:id]
       @comment = @blog.comments.build
       @comments = @blog.comments
       # binding.pry
    end
    def edit
       @blog = current_user.blogs.find params[:id]
    end
    def update
        @blog = current_user.blogs.find params[:id]
        @blog.update(params_create)
        redirect_to blogs_path
    end
    def destroy
        @blog = current_user.blogs.find params[:id]
        @blog.destroy
       redirect_to blogs_path
    end
    
    private
    
    def params_create
       params.require(:blog).permit(:title, :content, :user_id)
    end
    
    def user_signed
        redirect_to new_user_session_path unless user_signed_in?
    end
    
end
