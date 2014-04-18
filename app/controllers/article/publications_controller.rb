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

      if params[:keyword].empty?
        query_part = { 
            match_all: { }
        }
      else
        query_part = { 
            multi_match: {
              fields: ['title^2', 'content'],
              query: params[:keyword]
            }
          }
      end

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
            query: query_part
          }
        }
      }

      @publications = Publication.search(query).page(params[:page]).per(1).records

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
      @categories = Article::Category.all
    end
  end
end