class ShowPostDomain
    def execute(post_id:)
        Post.find(post_id)
    end
end
