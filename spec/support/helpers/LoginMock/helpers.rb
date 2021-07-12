module Helpers
  module LoginMock
    def login_with(user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    end
  end

  module APIHelpers
    def test_headers
      {
        'Accept'=>'*/*',
        'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
        'User-Agent'=>'Faraday v1.5.0'
      }
    end
  end
end