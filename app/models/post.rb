class Post < ApplicationRecord
  validates_presence_of :title
  has_many :comments, dependent: :destroy

  def self.search(term)
    if term
      where("lower(title || ' ' || body) LIKE ?", "%#{term.downcase}%")
      else
        all
    end
  end
end
