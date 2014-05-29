json.array!(@posts) do |post|
  json.extract! post, :id, :titulo, :body, :extension, :user_id
  json.url post_url(post, format: :json)
end
