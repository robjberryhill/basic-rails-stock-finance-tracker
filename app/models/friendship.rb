class Friendship < ApplicationRecord
  belongs_to :user
  # For self referential relationship the user and friend are the same table.
  # use this syntax to reference the User for friend.
  # friend has Friendship with user. through the friendship table. user.rb.
  belongs_to :friend, class_name: "User"
end
