class Reader
    DEFAULT_MIN_AGE = 18
    DEFAULT_PHONE = /^\+[\d]*$/

    attr_reader :name, :age, :address, :phone, :email

    def initialize(name, age, address, phone, email)
        valid?(name, age, phone)
        @name = name
        @age = age
        @address = address
        @phone = phone
        @email = email
    end

    def to_s
        "Reader { #{@name}, age: #{@age}, address: #{@address}, phone: #{@phone}, email: #{@email} }"
    end
    
    def ==(other)
        if other.is_a?(Reader)
            @name == other.name && @age == other.age && @address == other.address && 
            @phone == other.phone && @email == other.email
        end
    end

    private

    def valid?(name, age, phone)
        case
        when name.length == 0 
            raise ArgumentError, 'Unvalid name. Its length must be positive'
        when !age.is_a?(Integer)
            raise TypeError, "Unvalid age class (#{age} is #{age.class}). It must be integer"
        when age < DEFAULT_MIN_AGE
            raise ArgumentError, "Unvalid age (#{age}). It must be at least #{DEFAULT_MIN_AGE}"
        when !phone[DEFAULT_PHONE]
            raise ArgumentError, "Unvalid phone (#{phone}). It must start with + followed by digits"
        end
    end
end