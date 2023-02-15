class Post < ApplicationRecord
  belongs_to :user
  belongs_to :genre
  # ActiveStorageで投稿画像を保存する
  has_one_attached :post_image

  validates :title, presence: true
  validates :text, presence: true, length: { maximum: 200 }

end
