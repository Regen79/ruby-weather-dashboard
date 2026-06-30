class Device < ApplicationRecord
  belongs_to :user, default: -> { Current.user }
end
