require_relative 'entities/author'
require_relative 'entities/book'
require_relative 'entities/reader'
require_relative 'entities/order'
require_relative 'entities/library'

def test_exception (&block) 
    begin
        block.call
    rescue ArgumentError, TypeError => e
        puts e.message
    end
end

def puts_title(title)
    puts "\n" + '='*10 + title + '='*10
end

puts_title('Check unvalid arguments')
test_exception { Author.new('J', 1712) }
test_exception { Author.new('J.London', 2020) }
test_exception { Author.new('J.London', 20.20) }
author = Author.new('J.London', 1876, 'Bio')
puts "Valid author: #{author}"
puts

test_exception { Book.new('Moby Dick', 'J.London') }
test_exception { Book.new('', author) }
book = Book.new('Moby Dick', author, 'It\'s a great book')
puts "Valid book: #{book}"
puts

test_exception { Reader.new('', 12, '', '', '') }
test_exception { Reader.new('Olga', 12, '', '', '') }
test_exception { Reader.new('Olga', 20, '', '', '') }
test_exception { Reader.new('Olga', 20, '', '38', '') }
test_exception { Reader.new('Olga', 20, '', '+38098284219a', '') }
reader = Reader.new('Olga', 20, '', '+380982842194', 'olga.matsuga@gmail.com')
puts "Valid reader: #{reader}"
puts

test_exception { Order.new('reader', 'book') }
test_exception { Order.new(reader, 'book') }
test_exception { Order.new(reader, book, '2019-06-01') }
order = Order.new(reader, book, Time.new(2019, 06, 01))
puts "Valid order: #{order}"
order = Order.new(reader, book)
puts "Valid order: #{order}"
puts

puts_title('Create empty library')
library = Library.new
puts library
puts

author1 = Author.new('J.London', 1876, 'withoiut bio')
author2 = Author.new('J.Austen', 1775)
author3 = Author.new('W.Shakespeare', 1564, 'undefined bio')
author4 = Author.new('L.Tolstoy', 1828)

book1 = Book.new('Moby Dick', author1, 'It is a great book')
book2 = Book.new('Pride and prejudice', author2, 'It is very intresting book')
book3 = Book.new('Emma', author2)
book4 = Book.new('Hamlet', author3)
book5 = Book.new('Anna Karenina', author4)
book6 = Book.new('War and Peace', author4, 'It is a great book')

reader1 = Reader.new('Olga', 30, '', '+380982842194', 'olga.matsuga@gmail.com')
reader2 = Reader.new('Vasay', 25, '', '+380501111111', '')
reader3 = Reader.new('Eva', 45, '', '+380501111111', '')
reader4 = Reader.new('Tim', 20, '', '+380501111111', '')
reader5 = Reader.new('Elena', 35, '', '+380501111111', '')
reader6 = Reader.new('Vasay', 25, '', '+380501111111', '')
reader7 = Reader.new('Olga', 36, '', '+380982842194', 'olga.matsuga@gmail.com')

order1 = Order.new(reader1, book1)
order2 = Order.new(reader1, book5, Time.new(2018, 5, 1))
order3 = Order.new(reader1, book3)
order4 = Order.new(reader2, book1)
order5 = Order.new(reader3, book5)
order6 = Order.new(reader4, book6)
order7 = Order.new(reader4, book1)
order8 = Order.new(reader4, book1)
order9 = Order.new(reader5, book5)

puts_title('Create library with some unvalid entities')
library = Library.new([author1, ''], [book1, book2], [reader1, reader2], [order1, order2])
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
