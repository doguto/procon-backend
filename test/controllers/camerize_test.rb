require 'active_support'
require 'active_support/core_ext/string/inflections'

puts({ "foo_foo" => "bar_jo", "baz_rin" => 12 }.transform_keys { |key| key.to_s.camelize(:lower) }) if __FILE__ == $0
