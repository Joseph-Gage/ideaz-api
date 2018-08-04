class IdeaSerializer
  include FastJsonapi::ObjectSerializer
  set_id :id
  set_key_transform :camel_lower
  attributes :title, :description, :user_id
end
