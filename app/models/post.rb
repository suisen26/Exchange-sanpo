class Post < ApplicationRecord
  # ActiveStorageで投稿画像を保存する
  has_one_attached :post_image

  validates :text, presence: true, length: { maximum: 200 }
  validates :post_image, presence: true
  
  belongs_to :user
  belongs_to :genre

  def get_post_image(width, height)
    post_image.variant(resize_to_limit: [width, height]).processed
  end

end
