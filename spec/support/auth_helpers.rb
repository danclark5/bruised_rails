module AuthHelpers
  def log_in
    post sessions_path password: 'password'
  end

  def log_out
    get log_out_path
  end
end
