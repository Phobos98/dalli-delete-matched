require 'helper'

describe "DalliDeleteMatched" do
  describe "Cache Keys" do
    it "checks for cache keys" do
      assert_equal ActiveSupport::Cache::DalliStore.new('localhost:19122').send(:get_cache_keys), []
    end

    it "inserts a cache key and returns it as a key" do
      memcached(19122, '', {}) do |dc|
        store = ActiveSupport::Cache::DalliStore.new('localhost:19122')
        store.send :write_entry, "test", "content", {}

        assert_equal store.send(:get_cache_keys), ["test"]
      end
    end
  end
end
