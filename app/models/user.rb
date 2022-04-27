class User < ApplicationRecord
    has_secure_password
    validates_presence_of :username, :email
    valitades_uniqueness_of :email, :username
    validates_format_of :email, with: URI::MailTo::EMAIL_REGEXP
    # URI::MailTo::EMAIL_REGEXP is a class provided by the standard Ruby library which declares the regular expression EMAIL_REGEXP.

    # TODO: change solution to validating an email to check if it actually exists.


end
