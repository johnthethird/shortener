class ShortenerRedirectMiddleware
  def initialize(app)
    @app = app
  end

  def call(env)

    if (env["PATH_INFO"] =~ /^\/s\/(\w*)$/) && (shortener = ::Shortener::ShortenedUrl.find_for_redirect($1))
      [301, {'Location' => shortener.url}, []]
    else
      @app.call(env)
    end

  end
end
