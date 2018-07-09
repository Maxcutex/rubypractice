class Animal

    attr_accessor :kind

    def initialize
        @state = ""
        @kind = kind
    end 

    def eat(food)
        print "is eating #{food}" 
    end

    def sleep
        @state = "asleep"
    end

    def wake
        @state = "awake"
    end

end

class Person(age,gender,name) < Animal 
    attr_accessor :age,:gender,:name
    def initialize
        @kind = "Person"
        @age = 0
        @gender = ""
        @name = ""
    end 

    def eat(food)
        if food == "person"
            print "this is not allowed"
        else 
            print "is eating #{food}" 
        end 
    end

    def greet
        print "Hi, I'm #{@name}. I'm a person, and I'm #{@age} years old."
    end
end