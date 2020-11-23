p "accessed file"

json.posts @posts do |post|
  json.id post.id
  json.user do
    json.id post.user.id
    json.full_name post.user.full_name
    json.username post.user.username
    json.email post.user.email
  end
  json.message post.message
  json.created_at post.created_at
end