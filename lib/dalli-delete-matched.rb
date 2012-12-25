require 'active_support/cache/dalli_store'
require 'active_support/core_ext/module/aliasing'

ActiveSupport::Cache::DalliStore.class_eval do
    
  MEMCACHED_KEYS = "memcached_keys"
  
  alias_method :old_write_entry, :write_entry
  def write_entry(key, entry, options)
    keys = get_memcached_keys
    unless keys.include?(key)
      keys << key
      return false unless old_write_entry(MEMCACHED_KEYS, keys.to_yaml, {})
    end
    old_write_entry(key, entry, options)
  end
  
  alias_method :old_delete_entry, :delete_entry
  def delete_entry(key, options)
    ret = old_delete_entry(key, options)
    return false unless ret
    keys = get_memcached_keys
    if keys.include?(key)
      keys -= [ key ]
      old_write_entry(MEMCACHED_KEYS, keys.to_yaml, {})
    end
    ret
  end
  
  def delete_matched(matcher, options = nil)
    ret = true
    deleted_keys = []
    keys = get_memcached_keys
    keys.each do |key|
      if ret && key.match(matcher)
        deleted_keys << key if (ret = old_delete_entry(key, options))
      end
    end
    len = keys.length
    keys -= deleted_keys
    old_write_entry(MEMCACHED_KEYS, keys.to_yaml, {}) if keys.length < len
    ret
  end

private
  def get_memcached_keys
    begin
      YAML.load read(MEMCACHED_KEYS)
    rescue TypeError
      []
    end
  end
  
end