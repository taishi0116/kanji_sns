class Micropost < ApplicationRecord
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  mount_uploader :picture, PictureUploader
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 12  }
  validate  :picture_size
  
  def self.search(search)
    if search
      where(['content LIKE ?', "%#{search}%"])
    else
      all
    end
  end
  
  private
  
    def picture_size
      if picture.size > 5.megabytes
        errors.add(:picture, "容量が5MB以下の写真を指定してください")
      end
    end
end
