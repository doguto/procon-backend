module JsonExtention
  def camelize
    transform_keys { |key| key.to_s.camelize(:lower) }
  end
end

class ActiveSupport::JSON
  prepend JsonExtention
end
