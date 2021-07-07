class MoviesAPIMock
  def self.get(file_name)
    File.open(File.dirname(__FILE__) + '/mock_responses/' + file_name, 'rb').read
  end
end