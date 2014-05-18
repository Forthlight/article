module Article
  require 'elasticsearch/model'

  class Publication
    include Mongoid::Document
    include Mongoid::Timestamps
    include Concerns::Searchable

    before_save :sanitize_text
    before_update :sanitize_text
    after_save :update_index
    after_update :update_index

    belongs_to :type, :class_name => "Article::Type"
    belongs_to :category, :class_name => "Article::Category"
    belongs_to :cluster_category, :class_name => "Article::ClusterCategory"

    embeds_many :comments, :class_name => "Article::Comment"

    # Fields
    field :title, type: String
    field :content, type: String
    field :published, type: Boolean, default: false
    field :video_url, type: String
    field :author_type, type: String
    field :author, type: Integer
    field :rating, type: Integer

    validates_presence_of :type_id, :category_id, :cluster_category_id, :title, :content
    validates :title, presence: true, length: { maximum: 140 }, format: { with: /\A[a-zA-Z0-9_\s,\.&]+\Z/ }

    def sanitize_text
      self[:content] = CommonDomain::InputSanitizer.new.sanitize_this(self[:content])
    end

    def update_index
      self.__elasticsearch__.update_document
    end
  end
end