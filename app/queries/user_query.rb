class UserQuery
  def self.user_with_email(email:)
    User.find_by(email: email)
  end
end