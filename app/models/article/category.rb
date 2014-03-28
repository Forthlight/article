module Article
  class Category
    include Mongoid::Document

    require 'article/publication'

    has_many :publications

    # Fields
    field :title, type: String

    validates :title, presence: true, length: { maximum: 20 }, uniqueness: {case_sensitive: false}, format: { with: /\A[a-zA-Z0-9]+\Z/ }
  end
end