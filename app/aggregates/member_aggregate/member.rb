module MemberAggregate
  class Member
    extend Command::SignUp

    include Command::UpgradePremiumMember

    extend Query::Premium

    def initialize(member)
      @member = member
    end

    def premium?
      @member.premium?
    end

    def profile
      @member.member_detail.profile
    end
  end
end
