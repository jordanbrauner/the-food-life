class Box < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :recipes
end


# class Box < ActiveRecord::Base
#   belongs_to :user
#   belongs_to :recipe
#
#
#
#   # has_many :recipes
# end
