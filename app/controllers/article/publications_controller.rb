require_dependency "article/application_controller"

module Article
  class PublicationsController < ApplicationController
    def index
      @publications = Publication.all
    end

    def show
      @publications = Publication.all
    end
  end
end
