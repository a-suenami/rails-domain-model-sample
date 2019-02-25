# In controller

class MemberController < ApplicationController
  def index
    member_relation = Member.filter(search_params)
    @members = MemberSummaryMapper.map(member_relation, limit: 30, offset: params[:offset])
  end

  def search_params
    params.require(:member).permit(:keyword, :gender, :status)
  end
end
