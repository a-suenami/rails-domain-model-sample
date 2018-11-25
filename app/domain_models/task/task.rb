module Task
  class Task < Entity
    acts_as_aggregate_root

    attribute :title, Task::Title, required: true
    attribute :purpose, Task::Purpose, required: true
    attribute :status, Task::Status
  end
end
