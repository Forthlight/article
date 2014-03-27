module Article
  class Category
    include Mongoid::Document

    require 'article/publication'

    has_many :publications

    # Fields
    field :title, type: String


  end
end