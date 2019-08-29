module Finder

  # This module helps to instantiate ActiveRecords records by model class name and attribute name, to search with

  extend ActiveSupport::Concern

  included do

    def self.find(klass, param=:id)
      define_method("find_#{klass}") do
        is_own_param = self.class.to_s == "#{klass.to_s.camelize.pluralize}Controller"
        find_string     = "#{klass.to_s.camelize}.find_by(#{param}: params[:#{klass}_#{param}])"
        find_own_string = "#{klass.to_s.camelize}.find_by(#{param}: params[:#{param}])"

        instance_variable_set("@#{klass}", eval(is_own_param ? find_own_string : find_string))
      end

      private eval(":find_#{klass}")
    end
  end
end
