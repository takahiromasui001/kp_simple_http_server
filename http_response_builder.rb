class Kp::HttpResponseBuilder
  SERVER_ROOT_PATH = File.expand_path('src', __dir__)

  def initialize(parsed_request)
    @parsed_request = parsed_request
  end

  def build
    respond_with(build_path)
  end

  private

  def build_path
    raw_path = @parsed_request[:path]
    partial = raw_path == '/' ? '/index.html' : raw_path
    SERVER_ROOT_PATH + partial
  end

  def respond_with(path)
    if File.exist?(path)
      ok_response(File.binread(path))
    else
      not_found_response
    end
  end

  def ok_response(body)
    Kp::HttpResponse.new(code: 200, body:)
  end

  def not_found_response
    Kp::HttpResponse.new(code: 404)
  end
end
