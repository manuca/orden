require "orden/version"
require 'rack/utils'

class Orden
  attr_reader :default_attr, :default_dir

  def initialize(request, default_attr, default_dir = "asc")
    @request      = request
    @default_attr = default_attr
    @default_dir  = default_dir
  end

  def current_attribute
    query_hash["sort_attr"] ? query_hash["sort_attr"] : default_attr
  end

  def current_direction
    query_hash["sort_dir"] ? query_hash["sort_dir"] : default_dir
  end

  def sort_path(attr)
    h = query_hash.dup
    h["sort_attr"] = attr

    if attr == current_attribute
      h["sort_dir"] = opposite(current_direction)
    else
      h["sort_dir"] = "asc"
    end

    "#{@request.path}?#{Rack::Utils.build_query(h)}"
  end

  private

  def opposite(direction)
    direction == "asc" ? "desc" : "asc"
  end

  def query_hash
    @_query_hash ||= Rack::Utils.parse_query(@request.query_string)
  end
end
