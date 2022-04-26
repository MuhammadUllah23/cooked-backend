class User < ApplicationRecord
    has_secure_password
    validates :username, :email, presence: true
    valitades :email, :username, uniqueness: true
    


end
