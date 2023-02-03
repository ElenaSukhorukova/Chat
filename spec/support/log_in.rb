def log_in(user)
  get new_session_path
  post session_path, params: { email: user.email, password: '123Test123!+' }
  follow_redirect!
end

