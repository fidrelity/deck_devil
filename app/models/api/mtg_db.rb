module Api
  class MtgDb
    URL = "https://api.mtgdb.info/cards/"

    def queue(card)
      request = Typhoeus::Request.new(full_url(card))
      requests[card] = request
      hydra.queue(request)
      request
    end

    def run
      hydra.run
    end

    def responses
      Hash[requests.map{ |name,request| [name, request.response] } ]
    end

    private

    def hydra
      @hydra ||= Typhoeus::Hydra.new
    end

    def full_url(text)
      URL + Rack::Utils.escape(text)
    end

    def requests
      @requests ||= {}
    end
  end
end
