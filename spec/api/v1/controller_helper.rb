def create_user(username:, full_name:, email:, password:)
  user = instance_double("User", 
    username: username, 
    email: email, 
    full_name: full_name, 
    password: password)
end

def post_user(user)
  post '/api/v1/users', params: { 
    username: user.username, 
    email: user.email, 
    full_name: user.full_name, 
    password: user.password 
  }
end