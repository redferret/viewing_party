module Helpers
  module LoginMock
    def login_with(user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    end
  end
end