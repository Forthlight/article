module Article
  class Category
    include Mongoid::Document

    has_many :publications

    # Fields
    field :title, type: String
    field :description, type: String

    validates :title, presence: true, length: { maximum: 20 }, uniqueness: {case_sensitive: false}, format: { with: /\A[a-zA-Z0-9\s,\.&]+\Z/ }
  end
end