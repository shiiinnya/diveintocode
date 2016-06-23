class Question < ActiveRecord::Base
    has_many :messages
end
