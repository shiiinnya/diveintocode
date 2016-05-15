class InquiryController < ApplicationController
    
    before_action :user_signed, only: [:index, :confirm, :thanks]
    
    def index
        @inquiry = Inquiry.new
    end
    def confirm
       @inquiry = Inquiry.new(params_inquiry)
    if @inquiry.valid?
        render :action => "confirm"
    else
        render :action => "index"
    end
    end
    def thanks
        @inquiry = Inquiry.new(params_inquiry)
        if params[:back]
            render :action => "index"
        elsif
            @inquiry.save
            render :action => "thanks"
        else
            render :action => "thanks"
        end
    end
    private
    def params_inquiry
       params.require(:inquiry).permit(:name, :email, :birthday, :content) 
    end

  def user_signed
    redirect_to new_user_session_path unless user_signed_in?
  end
end
