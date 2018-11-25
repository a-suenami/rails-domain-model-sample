class MembersController < ApplicationController
  def index
    @members = Member::Member.all
  end

  def create
    @form = MemberRegistrationForm.new(member_registration_params)
    if @form.valid?
      @member = form.factory_member
      @member.store!
    else
      render :new, @form
    end
  end

  def update
    @member = Member::MemberRepository.find_by(id: params[:id])
    @form = MemberUpdateForm.new(member_update_params)
    if @form.valid?
      @member.update(@form)
      @member.store!
    else
      render :edit, @form
    end
  end
end
