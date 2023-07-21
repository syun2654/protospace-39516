class Comment < ApplicationRecord
  validates :content, presence: true
  #単体のアソシエーション
  belongs_to :prototype  
  belongs_to :user  
end
