require 'spec_helper'
require 'uri'
require 'rack/utils'

describe Orden do
  let(:default_attr) { "title" }; let(:default_dir) { "asc" }
  let(:sorter)   { Orden.new(request, default_attr, default_dir) }
  let(:path)     { "/path" }
  let(:request) do
    double("request", path: path, query_string: query_string)
  end

  def assert_equal_query(expected, got)
    expect(Rack::Utils.parse_query(got)).to eq(Rack::Utils.parse_query(expected))
  end

  describe "with empty query string" do
    let(:query_string) { "" }

    it "handles default sorting" do
      expect(sorter.current_attribute).to eq("title")
      expect(sorter.current_direction).to eq("asc")
    end

    describe "#sort_path" do
      describe "when sorting is not current sorting" do
        it "returns sort link with default options" do
          uri = URI.parse(sorter.sort_path("id"))
          assert_equal_query(uri.query, "sort_attr=id&sort_dir=#{default_dir}")
        end
      end

      describe "when sorting is current sorting" do
        it "returns sort for the opposite direction" do
          uri = URI.parse(sorter.sort_path("title"))
          expect(uri.path).to eq(path)
          assert_equal_query(uri.query, "sort_attr=title&sort_dir=desc")
        end
      end
    end
  end

  describe "when sorting is defined in query string" do
    let(:query_string) { "sort_dir=desc&sort_attr=id" }

    it "parses sorting options correctly" do
      expect(sorter.current_attribute).to eq("id")
      expect(sorter.current_direction).to eq("desc")
    end

    describe "when sorting is current sorting" do
      it "returns sort for the opposite direction" do
        uri = URI.parse(sorter.sort_path("id"))
        expect(uri.path).to eq(path)
        assert_equal_query(uri.query, "sort_attr=id&sort_dir=asc")
      end
    end
  end
end

