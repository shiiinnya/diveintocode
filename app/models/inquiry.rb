class Inquiry < ActiveRecord::Base
    validates :name, :presence => {:message => "を入力してください"}
    validates :email, :presence => {:message => "を入力してください"}
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, uniqueness: true, format: { with: VALID_EMAIL_REGEX, :message => "が不正です"}
end
