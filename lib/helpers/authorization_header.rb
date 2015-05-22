class AuthorizationHeader
  attr_reader :content

  def initialize(headers = {})
    @content = headers['Authorization'].to_s.split(' ').last
  end
end
