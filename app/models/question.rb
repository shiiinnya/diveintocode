class Question < ActiveRecord::Base
    has_many :messages, :dependent => :destroy
    belongs_to :user
end
