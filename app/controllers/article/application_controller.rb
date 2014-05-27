module Article
  class Article::ApplicationController < ::ApplicationController
    # Include helpers from common domain engine
    helper CommonDomain::Engine.helpers
  end
end
