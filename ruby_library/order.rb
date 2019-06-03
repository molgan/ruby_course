class Order
    attr_reader :reader, :book, :date

    def initialize(reader, book, date=Time.new)
        raise "Wrong reader class. It must be Reader" unless reader.is_a?(Reader)
        raise "Wrong book class. It must be Book" unless book.is_a?(Book)
        raise "Wrong date class. It must be Time" unless date.is_a?(Time)
        @reader = reader
        @book = book
        @date = date
    end

    def to_s
        "reader: #{@reader.name}, book: #{@book.name}, date: #{@date.strftime("%d-%m-%Y")}"
    end

    def ==(other)
        if other.is_a?(Order)
            @reader == other.reader && @book == other.book && @date == other.date
        else
            false
        end
    end
end 