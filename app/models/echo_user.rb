class EchoUser < ActiveRecord::Base
  belongs_to :authentication

  before_create :setup_registration_code

  def setup_registration_code
    code = rand(1000..9999)
    self.registration_code = code
  end

  def name
    authentication.try(:name)
  end

end
