module Article::Concerns::Searchable
  extend ActiveSupport::Concern

  included do
    include Elasticsearch::Model
    include Elasticsearch::Model::Callbacks

    settings index: { number_of_shards: 1, number_of_replicas: 0 } do
      mapping do
        indexes :title, analyzer: 'standard'
        indexes :content, analyzer: 'standard'
        indexes :author_type, analyzer: 'standard'
        indexes :created_at, type: 'date'
        indexes :published, type: 'boolean', analyzer: 'standard'

        indexes :type, type: 'nested' do
          indexes :title, index: :not_analyzed
        end

        indexes :cluster_category, type: 'nested' do
          indexes :title, index: :not_analyzed
        end

        indexes :category, type: 'nested' do
          indexes :title, index: :not_analyzed
        end
      end
    end

    def as_indexed_json(options={})
      {
        title: title,
        content: content,
        author_type: author_type,
        published: published,
        type: type.as_json(only: [:title]),
        cluster_category: cluster_category.as_json(only: [:title]),
        category: category.as_json(only: [:title])
      }
    end
  end
end