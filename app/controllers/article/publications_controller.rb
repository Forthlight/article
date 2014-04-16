require_dependency "article/application_controller"

module Article
  class PublicationsController < ApplicationController
    def index
      @publications = Article::Publication.all.page(params[:page]).per(2)
      checkbox_filters
    end

    def show
      @publication = Article::Publication.find(params[:id])
    end

    def search
      params[:types] ||= []
      params[:categories] ||= []

      types = params[:types].map(&:downcase)
      categories = params[:categories].map(&:downcase)

      query = { query: {
          filtered: {
            filter: {
              bool: {
                must: [
                  {terms: {
                    "type.title" => types
                  }},
                  {terms: {
                    "category.title" => categories
                  }}
                ]
              }
            },
            query: {
              multi_match: {
                fields: ['title^2', 'content'],
                query: params[:keyword]
              }
            }
          }
        }
      }

      @publications = Publication.search(query).records.page(params[:page]).per(1)

      checkbox_filters
      render :index
    end

    def checkbox_filters
      @types = Article::Type.all
      @categories = Article::Category.all
    end
  end
end