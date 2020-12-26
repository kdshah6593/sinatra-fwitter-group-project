class User < ActiveRecord::Base
  has_secure_password
  has_many :tweets

  def slug
    self.username.downcase.gsub(" ", "-")
  end

  def self.find_by_slug(slug_name)
    self.all.detect {|user| user.slug == slug_name}
  end
end
