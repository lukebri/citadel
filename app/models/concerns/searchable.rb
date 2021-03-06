module Searchable
  extend ActiveSupport::Concern

  included do
    include Elasticsearch::Model
    include Elasticsearch::Model::Callbacks
  end

  class_methods do
    def search_all(param)
      if param.blank?
        all
      else
        simple_search(param).records
      end
    end

    def simple_search(query)
      search(query: { simple_query_string: { query: query } })
    end
  end
end
