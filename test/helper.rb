$TESTING = true
require 'rubygems'

require 'minitest/pride'
require 'minitest/autorun'
require 'mocha/setup'

require 'active_support/all'
require 'active_support/cache/dalli_store'
require 'memcached_mock'

require 'dalli-delete-matched'

class MiniTest::Spec
  include MemcachedMock::Helper
end
