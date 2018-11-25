# ライブラリの中に入れるクラス
# とりあえずわかりやすさのため、ここに書く
class Enum
  def self.[](values)
    @@available_values = values
  end
end

module Task
  class Status < Enum[1..6]
    NEW = 1
    READY = 2
    IN_PROGRESS = 3
    IN_REVIEW = 4
    RELEASE_READY = 5
    DONE = 6

    def initialize(value)
    end
  end
end
