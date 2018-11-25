class Member::Member < Entity
  acts_as_aggregate_root

  # 便利メソッド使うパターン（こっちのほうがRubyっぽい）
  attribute :email, Member::Email, required: true
  attribute :first_name, Member::FirstName, required: true
  attribute :last_name, Member::LastName, required: true
  attribute :birth_date, Member::BirthDate, required: false
  attribute :profile_description, Member::ProfileDescription, required: false

  def initialize(email, first_name, last_name, birth_date, profile_description)
    # 愚直にコンストラクタでセットするパターン
    @email = Member::Email.new(email)
    @first_name = Member::FirstName.new(first_name)
    @last_name = Member::LastName.new(last_name)
    @birth_date = Member::BirthDate.new(birth_date)
    @profile_description = Member::ProfileDescription.new(profile_description)
  end

  def store!
  end
end
