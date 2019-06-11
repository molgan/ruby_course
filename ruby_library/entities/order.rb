# frozen_string_literal: true

# class Order
class Order
  attr_reader :reader, :book, :date

  def initialize(reader:, book:, date: Time.new)
    valid_reader?(reader)
    valid_book?(book)
    valid_date?(date)
    @reader = reader
    @book = book
    @date = date
  end

  def to_s
    "Order { reader: #{@reader.name}, book: #{@book.name}, date: #{@date.strftime('%d-%m-%Y')} }"
  end

  def ==(other)
    return unless other.is_a?(Order)

    @reader == other.reader && @book == other.book && @date == other.date
  end

  private

  def valid_reader?(reader)
    raise IncorrectClassError, Reader unless reader.is_a?(Reader)
  end

  def valid_book?(book)
    raise IncorrectClassError, Book unless book.is_a?(Book)
  end

  def valid_date?(date)
    raise IncorrectClassError, Time unless date.is_a?(Time)
  end
end
