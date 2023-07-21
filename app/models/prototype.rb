class Prototype < ApplicationRecord
  validates :title, presence: true
  validates :catch_copy, presence: true
  validates :concept, presence: true
  validates :image, presence: true
  #アソシエーション追加
  belongs_to :user #単体
  has_many :comments,dependent: :destroy #複数,プロトタイプが削除の場合はコメントも削除
  has_one_attached :image
end
