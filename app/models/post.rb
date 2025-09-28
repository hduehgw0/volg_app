class Post < ApplicationRecord
  belongs_to :user
  has_one_attached :eyecatch # Active Storageでアイキャッチ画像と紐付け

  validates :title, presence: true, length: { maximum: 50 }
  validates :content, presence: true

  # excerptが空の場合、contentの先頭100文字を自動で設定
  before_save :set_excerpt, if: -> { excerpt.blank? }

  private

  def set_excerpt
    self.excerpt = content.truncate(100)
  end
end
