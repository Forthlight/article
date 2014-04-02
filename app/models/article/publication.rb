module Article
  class Publication
    include Mongoid::Document
    include Mongoid::Timestamps

    belongs_to :type, :class_name => "Article::Type"
    belongs_to :category, :class_name => "Article::Category"

    # Fields
    field :title, type: String
    field :content, type: String
    field :published, type: Boolean, default: false
    field :video_url, type: String
    field :author, type: Integer
    # field :created_at, type: DateTime
    # field :updated_at, type: DateTime

  end
end