module Redmine
  class Project < ActiveResource::Base
    def self.find_all(url, user, password)
      self.site = url
      self.user = user
      self.password = password
      self.format = :xml
      find(:all)
    end

    def self.find_by_id(url, user, password, id)
      self.site = url
      self.user = user
      self.password = password
      self.format = :xml
      find(id)
    end
  end
end