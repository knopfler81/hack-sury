class Prospect < ApplicationRecord
  validates :email, format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i, message: "please fill with an email" }  
end
