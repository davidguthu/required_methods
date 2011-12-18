require 'helper'

class Vehicle
  include RequiredMethods
  required_class_methods :make, :model
  required_instance_methods :year, :mileage
end

class Car < Vehicle
  
end

class Truck < Vehicle
  
  def self.make
    "Chevy"
  end
  
  def self.model
    "Blazer"
  end
  
  def year
    1990
  end
  
  def mileage
    10000
  end
  
end

class TestRequiredMethods < Test::Unit::TestCase
  
  [:make, :model].each do |method|
    
    should "raise error if required class methods not defined" do
      assert_raise(RequiredMethods::NoRequiredMethodError) do
        Car.send(method)
      end
    end
    
    should "not raise error if required class methods not defined" do
      assert_nothing_raised do
        Truck.send(method)
      end
    end
    
  end
  
  [:year, :mileage].each do |method|
    
    should "raise error if required instance methods not defined" do
      assert_raise(RequiredMethods::NoRequiredMethodError) do
        Car.new.send(method)
      end
    end
    
    should "not raise error if required class_methods defined" do
      assert_nothing_raised do
        Truck.new.send(method)
      end
    end
    
  end
  
end
