class Blog < ActiveRecord::Base
    validates :title, presence: true, length: {minimum: 3}
    
    belongs_to :user
    
end
