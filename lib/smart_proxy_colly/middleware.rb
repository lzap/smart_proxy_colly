module Proxy::Colly::Traffic
  def self.queue
    @@queue ||= Queue.new
  end

  class Middleware
    def initialize(app)
      @app = app
    end

    def call(env)
      t0 = Time.now
      ret = @app.call env
      t1 = Time.now
      Proxy::Colly::Traffic.queue.push [t0, t1, ret, env]
      ret
    end
  end
end
