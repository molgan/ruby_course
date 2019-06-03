class Reader
    attr_reader :name, :age, :address, :phone, :email

    def initialize(name, age, address, phone, email)
        raise "Wrong name class. It must be String" unless name.is_a?(String)
        raise "Wrong age class. It must be Integer" unless age.is_a?(Integer)
        raise "Wrong address class. It must be String" unless address.is_a?(String)
        raise "Wrong phone class. It must be String" unless phone.is_a?(String)
        raise "Wrong email class. It must be String" unless email.is_a?(String)
        raise "Wrong reader name. Its size must be positive" unless name.size > 0
        raise "Wrong reader age #{age}. It must be at least 18" unless age >= 18
        raise "Wrong reader phone #{phone}. It must start with + and contain 12 digits" if phone.size != 13 || !phone[/^\+(\d){12}/]
        @name = name
        @age = age
        @address = address
        @phone = phone
        @email = email
    end

    def to_s
        "reader :#{@name}, age: #{@age}, address: #{@address}, phone: #{@phone}, email: #{@email}"
    end
    
    def ==(other)
        if other.is_a?(Reader)
            @name == other.name && @age == other.age && @address == other.address && 
            @phone == other.phone && @email == other.email
        else
            false
        end
    end
end