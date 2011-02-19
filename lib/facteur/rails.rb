module Facteur
  module Rails
    class Railtie < ::Rails::Railtie
      rake_tasks do
        load File.dirname(__FILE__) + "facteur/rails/tasks/facteur.rake"
      end
    end
  end
end