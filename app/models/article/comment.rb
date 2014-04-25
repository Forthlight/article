module Article
  class Comment
    include Mongoid::Document
    include Mongoid::Timestamps

   	embedded_in :publication, inverse_of: :comment, class_name: "Article::Publication"

    field :author, type: Integer
    field :content, type: String
    field :admin, type: Boolean

    validates :content, presence: true
  end
end