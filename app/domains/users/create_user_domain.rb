module Users
  class CreateUserDomain
    def initialize(params:)
      @params = params
    end

    def execute
      user = User.new(@params)
      if user.save
        user.create_profile unless user.profile
        Result.new(true, user, nil)
      else
        Result.new(false, nil, user.errors.full_messages)
      end
    end

    Result = Struct.new(:succcess?, :user, :errors)
  end
end
