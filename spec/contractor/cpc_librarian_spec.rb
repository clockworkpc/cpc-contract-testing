# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Contractor::CpcLibrarian do
  let(:new_books_json_path) { 'spec/fixtures/new_books.json' }

  context 'on Port 4002', online: true do
    url = 'http://localhost'
    port = 4002
    subject = Contractor::CpcLibrarian.new(url, port)

    # before(:all) do
    #   subject.delete_all_books
    # end

    new_book_hsh = {
      title: 'Hello, World, Yet Again!',
      author: 'Foo Bar III'
    }

    it 'should GET root page' do
      res = subject.get_root
      expect(res.code).to eq(200)
      expect(res.body).to eq("Welcome to the CPC Librarian on MongoDB, available at Port #{port}")
      expect(res.headers['x-powered-by']).to eq('Express')
    end

    it 'should GET all the books in the CPCLibrarian collection' do
      res = subject.get_all_books
      expect(res.code).to eq(200)
      expect(res.body[0]['title']).to eq(new_book_hsh[:title])
      expect(res.body[0]['author']).to eq(new_book_hsh[:author])
      expect(res.body.length).to eq(6)
    end
    
    it 'should GET book by ID' do
      first_book_hsh = subject.get_all_books.body[0]
      bookID_str = first_book_hsh['_id']
      title = first_book_hsh['title']
      author = first_book_hsh['author']
      res = subject.get_book_by_id(bookID_str)
      expect(res.code).to eq(200)
      expect(res.body['title']).to eq(title)
      expect(res.body['author']).to eq(author)
      puts res.body
    end


    # it 'should POST a new book to the CpcLibrarian collection' do
    #   res = subject.post_book(new_book_hsh)
    #   expect(res.code).to eq(200)
    #   expect(res.body['title']).to eq(new_book_hsh[:title])
    #   expect(res.body['author']).to eq(new_book_hsh[:author])
    # end
    #
    # it 'should POST a collection of new books from JSON' do
    #   book_hsh_ary = JSON.parse(File.read(new_books_json_path))
    #   res = subject.post_books(new_books_json_path)
    #   expect(res.count).to eq(book_hsh_ary.count)
    # end
    #
    #
    # it 'should DELETE the latest book in the collection' do
    #   protected_id_ary = ['5e20e90380c9c830e74c6335']
    #
    #   all_books = subject.get_all_books.body
    #   deletable_books = all_books.reject { |h| protected_id_ary.include?(h['_id']) }
    #   deletable_ids = deletable_books.map { |h| h['_id'] }
    #   expect(deletable_ids.count).to eq(all_books.count)
    #   id_to_delete = deletable_ids.last
    #
    #   res = subject.delete_latest_book(protected_id_ary)
    #   expect(res.code).to eq(200)
    #   expect(res.body['id']).to eq(id_to_delete)
    #   expect(subject.get_all_books.body.count).to eq(all_books.count - 1)
    # end

    # it 'should GET a book by ID' do
    #   book_hsh_ary = JSON.parse(File.read(new_books_json_path))
    #   last_book_hsh = book_hsh_ary[-2]
    #   bookID_str = subject.get_latest_book['_id']
    #   res = subject.get_book_by_id(bookID_str)
    #   expect(res.headers['x-powered-by']).to eq('Express')
    #   expect(res.body['_id']).to eq(bookID_str)
    #   expect(res.body['title']).to eq(last_book_hsh['title'])
    #   expect(res.body['author']).to eq(last_book_hsh['author'])
    # end
    #
    #
    # it 'should PUT a book by ID' do
    #   book_hsh_ary = JSON.parse(File.read(new_books_json_path))
    #   last_book_hsh = book_hsh_ary[-2]
    #   bookID_str = subject.get_latest_book['_id']
    #   book_hsh = {
    #     _id: bookID_str,
    #     title: 'No True Highlander',
    #     author: 'Hamish MacDonald'
    #   }
    #
    #   puts "Title before PUT: #{subject.get_latest_book['title']}"
    #
    #   res = subject.put_book(book_hsh)
    #   expect(res.headers['x-powered-by']).to eq('Express')
    #   expect(res.body['_id']).to eq(bookID_str)
    #   expect(res.body['title']).to eq(book_hsh[:title])
    #   expect(res.body['author']).to eq(book_hsh[:author])
    #
    #   puts "Title after PUT: #{subject.get_latest_book['title']}"
    # end
  end
end
