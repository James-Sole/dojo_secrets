class Like < ActiveRecord::Base
  belongs_to :user, required: true
  belongs_to :secret, required: true
end
