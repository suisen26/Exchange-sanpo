class Post < ApplicationRecord
  belongs_to :user
  belongs_to :genre, optional: true
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  # ActiveStorageで投稿画像を保存する
  has_one_attached :post_image

  validates :text, presence: true, length: { maximum: 200 }
  validates :post_image, presence: true
  validates :genre_id, presence: true
  
  # def get_post_image
  #   (post_image.attached?) ? post_image : 'no_image.jpg'
  # end

  def get_post_image(width, height)
    post_image.variant(resize_to_limit: [width, height]).processed
  end
  
  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
  
  # 検索方法分岐
  def self.search_for(content, method)
    if method == "perfect"
      Post.where(title: content)
    elsif method == "forward"
      Post.where("title LIKE ?", content + "%")
    elsif method == "backward"
      Post.where("title LIKE ?", "%" + content)
    else
      Post.where("title LIKE ?", "%" + content + "%")
    end
  end

end
