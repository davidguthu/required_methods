require 'active_support/concern'

module RequiredMethods
  extend ActiveSupport::Concern
  
  class NoRequiredMethodError < NoMethodError
  end
  
  module ClassMethods
    
    def required_class_methods(*args)
      @@required_class_methods = args
    end
    
    def requires_class_method?(method)
      @@required_class_methods.include?(method)
    end
    
    def required_instance_methods(*args)
      @@required_instance_methods = args
    end
    
    def requires_instance_method?(method)
      @@required_instance_methods.include?(method)
    end
    
    def method_missing(method_sym, *arguments, &block)
      if requires_class_method?(method_sym)
        raise NoRequiredMethodError.new("#{name} requires class method #{method_sym}")
      else
        super
      end
    end
    
  end
  
  module InstanceMethods
    
    def method_missing(method, *arguments, &block)
      if self.class.requires_instance_method?(method)
        raise NoRequiredMethodError.new("#{self.class.name} requires instance method #{method}")
      else
        super
      end
    end
    
  end
  
end