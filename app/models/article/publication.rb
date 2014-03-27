module Article
  class Publication
    include Mongoid::Document

    belongs_to :type
    belongs_to :category

    # Fields
    field :title, type: String
    field :content, type: String
    field :published, type: Boolean
    field :created_at, type: DateTime
    field :updated_at, type: DateTime
    field :video_url, type: String

  end
end