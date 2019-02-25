# app/controllers/members_controller.rb
class MembersController < ApplicationController
  def index
    @members = MemberPresenterMapper.map(rel, limit: 10)
  end

  def new
  end

  def create
    command = MemberRegistrationCommand.new(registration_params)
    if command.valid?
      event = MemberRegisteredEvent.new(command)
      state = event.handle!
      @member = state.member_presenter
    else
      render :new
    end
  end

  private

  def registration_params
    params.require(:member).permit(:first_name, :last_name, :birth_date)
  end
end

# app/presenters/member_presenter.rb
class MemberPresenter
  attr_accessor :id, :first_name, :last_name, :birth_date

  composition :full_name, -> (member) { Member::FullName.new(member.first_name, member.last_name) }
  composition :age, -> (member) { Member::Age.new(member.birth_date) }
end

class MemberPresenterMapper
  set :type, MemberPresenter

  def self.map(relation, limit: nil)
    relation = relation.limit(limit) if limit.present?
    relation.map do |record|
      type.new(record.to_h)
    end
  end
end

# app/helpers/application_helper.rb
class ApplicationHelper
  # いらない気がした
  # def display_value_object(vo)
  #   klass_name = vo.class.name
  #   m = "display_#{klass_name}"
  #   respond_to?(m) ? send(m(vo)) : vo.to_s
  # end
  # alias :display_value_object :d

  def format(vo, format_pattern)
    vo.format(format, format_pattern)
  end
  alias :format :f
end

# app/views/members/index.html.erb
# <table>
#   <tr>
#     <th>ID</th>
#     <th>Name</th>
#     <th>Age</th>
#   </tr>
#   <% members.each do |member| %>
#     <tr>
#       <th><%= member.id %></th>
#       <th><%= member.full_name %></th>
#       <th><%=f member.age, '%{age} 歳' %></th>
#     </tr>
#   <% end %>
# </table>

# app/value_objects/member/full_name.rb
class MemberFullName
  def initialize(first_name, last_name)
    @first_name = first_name
    @last_name = last_name
  end

  def to_s
    "#{first_name} #{last_name}"
  end

  def format(pattern)
    # Override if needed
    to_s
  end
end
