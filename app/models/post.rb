class Post < ApplicationRecord
  # ActiveStorageで投稿画像を保存する
  has_one_attached :post_image
  
  belongs_to :user
  belongs_to :genre, optional: true

  validates :text, presence: true, length: { maximum: 200 }
  validates :post_image, presence: true
  validates :genre_id, presence: true

  def get_post_image(width, height)
    post_image.variant(resize_to_limit: [width, height]).processed
  end

end
