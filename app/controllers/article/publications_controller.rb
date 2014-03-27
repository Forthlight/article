require_dependency "article/application_controller"

module Article
  class PublicationsController < ApplicationController
    def index
      @publications = Publication.all
    end

    def show
    end

    def create
    end

    def new
    end

    def update
    end

    def edit
    end

    def destroy
    end
  end
end
