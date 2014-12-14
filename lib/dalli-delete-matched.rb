require 'active_support/cache/dalli_store'
require 'active_support/core_ext/module/aliasing'

ActiveSupport::Cache::DalliStore.class_eval do

  CACHE_KEYS = "CacheKeys"

  alias_method :old_write_entry, :write_entry
  def write_entry(key, entry, options)
    keys = get_cache_keys
    unless keys.include?(key)
      keys << key
      delete CACHE_KEYS
      return false unless write_cache_keys(keys, options[:connection])
    end
    old_write_entry(key, entry, options)
  end

  alias_method :old_delete_entry, :delete_entry
  def delete_entry(key, options)
    ret = old_delete_entry(key, options)
    return false unless ret
    keys = get_cache_keys
    if keys.include?(key)
      keys -= [ key ]
      delete CACHE_KEYS
      with { |c| write_cache_keys(keys, c) }
    end
    ret
  end

  def delete_matched(matcher, options = {})
    ret = true
    deleted_keys = []
    keys = get_cache_keys
    keys.each do |key|
      if ret && key.match(matcher)
        deleted_keys << key if (ret = old_delete_entry(key, options))
      end
    end
    len = keys.length
    keys -= deleted_keys
    if keys.length < len
      with { |c| write_cache_keys(keys, c) }
    end
    ret
  end

private

  def write_cache_keys(keys, connection)
    old_write_entry(CACHE_KEYS, keys.to_yaml, { :connection => connection })
  end

  def get_cache_keys
    begin
      YAML.load read(CACHE_KEYS)
    rescue TypeError
      []
    end
  end

end
