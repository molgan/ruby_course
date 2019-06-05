class Order
    attr_reader :reader, :book, :date

    def initialize(reader, book, date=Time.new)
        valid?(reader, book, date)
        @reader = reader
        @book = book
        @date = date
    end

    def to_s
        "Order { reader: #{@reader.name}, book: #{@book.name}, date: #{@date.strftime("%d-%m-%Y")} }"
    end

    def ==(other)
        if other.is_a?(Order)
            @reader == other.reader && @book == other.book && @date == other.date
        end
    end

    private

    def valid?(reader, book, date)
        case
        when !reader.is_a?(Reader)
            raise TypeError, 'Unvalid reader class. It must be Reader'
        when !book.is_a?(Book)
            raise TypeError, 'Unvalid book class. It must be Book' 
        when !date.is_a?(Time)
            raise TypeError, 'Unvalid date class. It must be Time'
        end
    end
end 