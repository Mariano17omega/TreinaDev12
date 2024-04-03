class Director < ApplicationRecord
    has_many :movies
    validates :birthdate, format: { with: /\A\d{4}-\d{2}-\d{2}\z/, message: "deve estar no formato AAAA-MM-DD" }
end
