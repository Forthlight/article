module Article
  class ClusterCategory
    include Mongoid::Document

    has_many :publications

    before_save :sanitize_title
    before_update :sanitize_title

    # Fields
    field :title, type: String
    field :description, type: String

    validates :title, presence: true, length: { maximum: 20 }, uniqueness: {case_sensitive: false}, format: { with: /\A[a-zA-Z0-9_\s,\.&]+\Z/ }
    validates :description, presence: true, length: { maximum: 255 }, format: { with: /\A[a-zA-Z0-9\s]+\Z/ }

    def sanitize_title
      self.title = self.title.gsub(/\s+/, "_")
    end
  end
end