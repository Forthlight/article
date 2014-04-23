require_dependency "administration/application_controller"

module Article
	class CommentsController < ApplicationController
    skip_before_filter :authenticate_admin!, only: [:create]

		def create
      @publication = Article::Publication.find(params[:publication_id])

      if admin_signed_in? && !user_signed_in?
        params[:comment][:author] = current_admin.id
        params[:comment][:admin] = true
      else
        params[:comment][:author] = current_user.id
        params[:comment][:admin] = false
      end

      comment = @publication.comments.create!(comment_params)

      redirect_to @publication
    end

    def destroy
    end

    private
    def comment_params
      allow = [:content, :admin, :author]
      params.require(:comment).permit(allow)
    end
  end
end
