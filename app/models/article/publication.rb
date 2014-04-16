module Article
  require 'elasticsearch/model'

  class Publication
    include Mongoid::Document
    include Mongoid::Timestamps
    include Concerns::Searchable

    belongs_to :type, :class_name => "Article::Type"
    belongs_to :category, :class_name => "Article::Category"

    # Fields
    field :title, type: String
    field :content, type: String
    field :published, type: Boolean, default: false
    field :video_url, type: String
    field :author, type: Integer
  end
end