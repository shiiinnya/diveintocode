class BlogsController < ApplicationController
    def index
       @blog = Blog.all 
    end
    def new
        @blog = Blog.new
    end
    def create
       @blog = Blog.new(params_create)
     if @blog.save
        redirect_to blogs_path
     else
        render "new"
     end
    end
    def show
       @blog = Blog.find params[:id] 
    end
    def edit
       @blog = Blog.find params[:id] 
    end
    def update
        @blog = Blog.find params[:id]
        @blog.update(params_create)
        redirect_to blogs_path
    end
    def destroy
       @blog = Blog.find params[:id]
       @blog.destroy
       redirect_to blogs_path
    end
    
    private
    def params_create
       params.require(:blog).permit(:title, :content) 
    end
    
    
end
