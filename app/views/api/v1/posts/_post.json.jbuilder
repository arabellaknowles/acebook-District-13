json.id post.id
json.user do
  json.id post.user.id
  json.full_name post.user.full_name
  json.username post.user.username
  json.email post.user.email
end
json.message post.message
json.created_at post.created_at
json.editable post.editable?(@current_user.id)
json.owned_by post.owned_by?(@current_user.id)