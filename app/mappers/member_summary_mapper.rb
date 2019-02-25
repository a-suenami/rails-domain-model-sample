class MemberSummaryMapper < BaseMapper
  set_target_class Member

  def map_row(row)
    map_target = obj_class
    obj.name = row.name
    obj.email = row.email
  end
end
