require_dependency "article/application_controller"

module Article
  class PublicationsController < ApplicationController
    def index
      @publications = Article::Publication.all.page(params[:page]).per(10)
      checkbox_filters
    end

    def show
      @publication = Article::Publication.find(params[:id])

      query = { query: {
          filtered: {
            filter: {
              bool: {
                should: [
                  {terms: {
                    "type.title" => [@publication.type.title.downcase]
                  }},
                  {terms: {
                    "cluster_category.title" => [@publication.cluster_category.title.downcase]
                  }},
                  {terms: {
                    "category.title" => [@publication.category.title.downcase]
                  }}
                ]
              }
            },
            query: {
              match_all: { }
            }
          }
        },
        size: 5
      }

      @related = Article::Publication.search(query).records
    end

    def search
      params[:types] ||= []
      params[:clusters] ||= []
      params[:categories] ||= []

      types = params[:types].map(&:downcase)
      clusters = params[:clusters].map(&:downcase)
      categories = params[:categories].map(&:downcase)

      @cc = clusters

      # if no keyword present match all (with filters), otherwise match against keyword also
      if params[:keyword].blank?
        query_part = { 
            match_all: { }
        }
      else
        query_part = { 
            multi_match: {
              fields: ['title^10', 'content'],
              query: params[:keyword]
            }
          }
      end

      # if no filters are present, only use the keyword or match all (this will be used by search in header)
      if types.blank? && clusters.blank? && categories.blank?
        query = { query: {
            filtered: {
              query: query_part
            }
          }
        }
      else
        query = { query: {
            filtered: {
              filter: {
                bool: {
                  must: [
                    {terms: {
                      "type.title" => types
                    }},
                    {terms: {
                      "cluster_category.title" => clusters
                    }},
                    {terms: {
                      "category.title" => categories
                    }}
                  ]
                }
              },
              query: query_part
            }
          }
        }
      end
      

      @publications = Publication.search(query).page(params[:page]).per(10).records

      checkbox_filters
      render :index
    end

    def rate
      publication = Article::Publication.find(params[:id])
      publication.inc(rating: 1)

      respond_to do |format|
        format.json { render :json => publication.rating}
      end
    end

    def checkbox_filters
      @types = Article::Type.all
      @clusters = Article::ClusterCategory.all
      @categories = Article::Category.all
    end
  end
end