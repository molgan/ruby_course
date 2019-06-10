require_relative 'storage/storage'
require_relative 'errors/errors'
require_relative 'entities/author'
require_relative 'entities/book'
require_relative 'entities/reader'
require_relative 'entities/order'
require_relative 'entities/library'

def test_exception (&block) 
    begin
        block.call
    rescue IncorrectClassError, InvalidLengthError, InvalidValueError => e
        puts e.message
    end
end

def puts_title(title)
    puts "\n" + '='*10 + title + '='*10
end

puts_title('Check unvalid arguments')
test_exception { Author.new(name: 'J', year: 1712) }
test_exception { Author.new(name: 'J.London', year: 2020) }
test_exception { Author.new(name: 'J.London', year: 20.20) }
author = Author.new(name: 'J.London', year: 1876, bio: 'Bio')
puts "Valid author: #{author}"
puts

test_exception { Book.new(name: 'Moby Dick', author: 'J.London') }
test_exception { Book.new(name: '', author: author) }
book = Book.new(name: 'Moby Dick', author: author, description: 'It\'s a great book')
puts "Valid book: #{book}"
puts

test_exception { Reader.new(name: '', age: 12) }
test_exception { Reader.new(name: 'Olga', age: 12) }
test_exception { Reader.new(name: 'Olga', age: 20) }
test_exception { Reader.new(name: 'Olga', age: 20, phone: '38098284219') }
test_exception { Reader.new(name: 'Olga', age: 20, phone: '+38098284219a') }
reader = Reader.new(name: 'Olga', age: 20, phone: '+380982842194', email: 'olga.matsuga@gmail.com')
puts "Valid reader: #{reader}"
puts

test_exception { Order.new(reader: 'reader', book: 'book') }
test_exception { Order.new(reader: reader, book: 'book') }
test_exception { Order.new(reader: reader, book: book, date: '2019-06-01') }
order = Order.new(reader: reader, book: book, date: Time.new(2019, 06, 01))
puts "Valid order: #{order}"
order = Order.new(reader: reader, book: book)
puts "Valid order: #{order}"
puts

puts_title('Create empty library')
library = Library.new
puts library
puts

author1 = Author.new(name: 'J.London', year: 1876, bio: 'withoiut bio')
author2 = Author.new(name: 'J.Austen', year: 1775)
author3 = Author.new(name: 'W.Shakespeare', year: 1564, bio: 'undefined bio')
author4 = Author.new(name: 'L.Tolstoy', year: 1828)

book1 = Book.new(name: 'Moby Dick', author: author1, description: 'It is a great book')
book2 = Book.new(name: 'Pride and prejudice', author: author2, description: 'It is very intresting book')
book3 = Book.new(name: 'Emma', author: author2)
book3 = Book.new(name: 'Emma', author: author2)
book4 = Book.new(name: 'Hamlet', author:author3)
book5 = Book.new(name: 'Anna Karenina', author: author4)
book6 = Book.new(name: 'War and Peace', author: author4, description: 'It is a great book')

reader1 = Reader.new(name: 'Olga', age: 30, phone: '+380982842194', email: 'olga.matsuga@gmail.com')
reader2 = Reader.new(name: 'Vasay', age: 25, phone: '+380501111111')
reader3 = Reader.new(name: 'Eva', age: 45, phone: '+380501111111')
reader4 = Reader.new(name: 'Tim', age: 20, phone: '+380501111111')
reader5 = Reader.new(name: 'Elena', age: 35, phone: '+380501111111')
reader6 = Reader.new(name: 'Vasay', age: 25, phone: '+380501111111')
reader7 = Reader.new(name: 'Olga', age: 36, phone: '+380982842194', email: 'olga.matsuga@gmail.com')

order1 = Order.new(reader: reader1, book: book1)
order2 = Order.new(reader: reader1, book: book5, date: Time.new(2018, 5, 1))
order3 = Order.new(reader: reader1, book: book3)
order4 = Order.new(reader: reader2, book: book1)
order5 = Order.new(reader: reader3, book: book5)
order6 = Order.new(reader: reader4, book: book6)
order7 = Order.new(reader: reader4, book: book1)
order8 = Order.new(reader: reader4, book: book1)
order9 = Order.new(reader: reader5, book: book5)

puts_title('Create library with some unvalid entities')
library = Library.new(authors: [author1, ''], books: [book1, book2], readers: [reader1, reader2], orders: [order1, order2])
puts library
puts

puts_title('Save it to library1.yml')
library.save('data/library1.yml')
puts

puts_title('Library after adding some new entities')
library + author3
library.add(author4)
library.add(book3, book4)
library.add([book5, book6])
library.add(reader3, reader4, reader5)
library.add(reader6, reader7, order2, order3)
library + order4
library + order5
library + order6
library + order7
library + order8
library + order9
puts library
puts

puts_title('Save it to library2.yml')
library.save('data/library2.yml')
puts

puts_title('Library after loading from library1.yml')
library.load('data/library1.yml')
puts library
puts

puts_title('Library after loading from library2.yml')
library.load('data/library2.yml')
puts library
puts

library.load('library1.yml')

puts_title('Statistics for library')
puts "The most popular book: #{library.top_book.name}"
puts 'The 3 most popular books:'
library.top_books.each { |book| puts "#{book.name}"}
puts 'The 3 most popular readers:'
library.top_readers.each { |reader| puts "#{reader.name}"}
puts "Count of the 3 most popular books readers: #{library.count_of_top_books_readers}"
puts "Count of the 2 most popular books readers: #{library.count_of_top_books_readers(2)}"
puts "Count of the 1 most popular books readers: #{library.count_of_top_books_readers(1)}"
puts

puts_title('Statistics for empty library')
library = Library.new
puts "The most popular book: #{library.top_book}"
puts "The 3 most popular books: #{library.top_books}"
puts "The 3 most popular readers: #{library.top_readers}"
puts "Count of the 3 most popular books readers: #{library.count_of_top_books_readers}"
