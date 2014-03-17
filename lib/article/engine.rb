module Article
  class Engine < ::Rails::Engine
    isolate_namespace Article
  end
end
