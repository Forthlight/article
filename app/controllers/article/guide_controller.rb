require_dependency "article/application_controller"

module Article
  class GuideController < ApplicationController
    include Wicked::Wizard

    steps :type, :category, :cluster, :keyword, :search

    def show
      case step
        when :type
          @types = Article::Type.all
          render_wizard
        when :category
          session[:types] = params[:types] ||= []
          @categories = Article::Category.all
          render_wizard
        when :cluster
          session[:categories] = params[:categories] ||= []
          @clusters = Article::ClusterCategory.all
          render_wizard
        when :keyword
          session[:clusters] = params[:clusters] ||= []
          render_wizard
        when :search
          session[:keyword] = params[:keyword] ||= []
          redirect_to finish_wizard_path
      end
    end

    def index
      types = session[:types].map(&:downcase)
      clusters = session[:clusters].map(&:downcase)
      categories = session[:categories].map(&:downcase)

      if session[:keyword].blank?
        query_part = { 
            match_all: { }
        }
      else
        query_part = { 
            multi_match: {
              fields: ['title^2', 'content'],
              query: session[:keyword]
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

      @publications = Article::Publication.search(query).page(params[:page]).per(1).records
      
      render :index
    end

    def finish_wizard_path
      article.guide_index_path
    end
  end
end
