class Vote < ApplicationRecord
  belongs_to :user, foreign_key: "vote_id"
end
