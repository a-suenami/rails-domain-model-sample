module Member
  class Email < ValueObject
    validates :value, /.+@.+/

    def initialize(value)
      @value = value
    end
  end
end
