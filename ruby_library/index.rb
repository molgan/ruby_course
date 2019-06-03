require_relative "author"
require_relative "book"
require_relative "reader"
require_relative "order"
require_relative "library"


def test_exception (&block) 
    begin
        block.call
    rescue Exception => e
        puts e.message
    end
end


test_exception { Author.new("J", 2020) }
test_exception { Author.new("J.London", 2020) }
test_exception { Author.new("J.London", 1876, 5) }
author = Author.new("J.London", 1876, 'bio')
puts "Correct author is <#{author}>"
puts


test_exception { Book.new("Moby Dick", "J.London") }
test_exception { Book.new("", author) }
book = Book.new("Moby Dick", author, "It's a great book")
puts "Correct book is <#{book}>"
puts


test_exception { Reader.new("", 12, "", "", "") }
test_exception { Reader.new("Olga", 12, "", "", "") }
test_exception { Reader.new("Olga", 20, "", "", "") }
test_exception { Reader.new("Olga", 20, "", "38", "") }
test_exception { Reader.new("Olga", 20, "", "+38098284219a", "") }
reader = Reader.new("Olga", 20, "", "+380982842194", "olga.matsuga@gmail.com")
puts "Correct reader is <#{reader}>"
puts


test_exception { Order.new("reader", "book") }
test_exception { Order.new(reader, "book") }
test_exception { Order.new(reader, book, "2019-06-01") }
order = Order.new(reader, book, Time.new(2019, 06, 01))
puts "Correct order is <#{order}>"
order = Order.new(reader, book)
puts "Correct order is <#{order}>"
puts


library = Library.new
puts "#{library}\n"


author1 = Author.new("J.London", 1876)
author2 = Author.new("J.Austen", 1775)
author3 = Author.new("W.Shakespeare", 1564)
author4 = Author.new("L.Tolstoy", 1828)

book1 = Book.new("Moby Dick", author1)
book2 = Book.new("Pride and prejudice", author2)
book3 = Book.new("Emma", author2)
book4 = Book.new("Hamlet", author3)
book5 = Book.new("Anna Karenina", author4)
book6 = Book.new("War and Peace", author4)

reader1 = Reader.new("Olga", 30, "", "+380982842194", "olga.matsuga@gmail.com")
reader2 = Reader.new("Vasay", 25, "", "+380501111111", "")
reader3 = Reader.new("Eva", 45, "", "+380501111111", "")
reader4 = Reader.new("Tim", 20, "", "+380501111111", "")
reader5 = Reader.new("Elena", 35, "", "+380501111111", "")
reader6 = Reader.new("Vasay", 25, "", "+380501111111", "")
reader7 = Reader.new("Olga", 36, "", "+380982842194", "olga.matsuga@gmail.com")

order1 = Order.new(reader1, book1)
order2 = Order.new(reader1, book5, Time.new(2018, 5, 1))
order3 = Order.new(reader1, book3)
order4 = Order.new(reader2, book1)
order5 = Order.new(reader3, book5)
order6 = Order.new(reader4, book6)
order7 = Order.new(reader4, book1)
order8 = Order.new(reader4, book1)
order9 = Order.new(reader5, book5)


library = Library.new([author1, ""], [book1, book2], [reader1, reader2], [order1, order2])
puts "#{library}\n"

library + author3
library.add_author(author4)
library.add_book(book3)
library.add(book4)
library + book5
library + book6
library.add_reader(reader3)
library.add(reader4)
library + reader5
library + reader6
library + reader7
library.add_order(order2)
library.add(order3)
library + order4
library + order5
library + order6
library + order7
library + order8
library + order9
puts "#{library}\n"


library.save("library.yml")
library2 = Library.new
puts "#{library2}\n"
library2.load("lib.yml")
puts "#{library2}\n"
library2.load("library.yml")
puts "#{library2}\n"

puts "For empty library"
library2 = Library.new
puts "The most popular book: #{library2.the_most_popular_book}"
puts "The 3 most popular books: #{library2.the_most_popular_books}"
puts "The 3 most popular readers: #{library2.the_most_popular_books}"
puts "Count of readers of the 3 most popular books: #{library2.count_of_readers_of_the_most_popular_books}"
puts

puts "For the full library"
puts "The most popular book: #{library.the_most_popular_book.name}"
puts "The 3 most popular books: "
library.the_most_popular_books.each { |book| puts "#{book.name}"}
puts "The 3 most popular readers: "
library.the_most_popular_readers.each { |reader| puts "#{reader.name}"}
puts "Count of readers of the 3 most popular books: #{library.count_of_readers_of_the_most_popular_books}"
puts "Count of readers of the 2 most popular books: #{library.count_of_readers_of_the_most_popular_books(2)}"
puts "Count of readers of the 1 most popular books: #{library.count_of_readers_of_the_most_popular_books(1)}"
