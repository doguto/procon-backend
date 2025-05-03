module Posts
  class ShowPostDomain
    def initialize(id:)
      @id = id
    end

    def execute
      Post.find(@id)
    end
  end
end
