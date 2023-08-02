module ApplicationHelper
  def camelize_keys(hash)
    hash.deep_transform_keys! { |key| key.camelize(:lower) }
  end
end
