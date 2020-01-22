# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Contractor::CpcLibrarian do
  let(:new_books_json_path) { 'spec/fixtures/new_books.json' }

  context 'on Port 4002', online: true do
    url = 'http://localhost'
    port = 4002
    subject = Contractor::CpcBibliotheque.new(url, port)

    # before(:all) do
    #   subject.delete_all_books
    # end

    new_book_hsh = {
      title: 'Hello, World, Yet Again!',
      author: 'Foo Bar III'
    }

    it 'should GET root page' do
      res = subject.get_root
      expect(res.status).to eq(200)
      expect(res.body).to eq("Welcome to the CPC Librarian on MongoDB, available at Port #{port}")
      expect(res.headers['x-powered-by']).to eq('Express')
    end

    it "should" do

    end

    it 'should GET all the books in the CPCLibrarian collection' do
      res = subject.get_all_books
      expect(res.status).to eq(200)
      expect(JSON.parse(res.body)[0]['title']).to eq(new_book_hsh[:title])
      expect(JSON.parse(res.body)[0]['author']).to eq(new_book_hsh[:author])
      expect(JSON.parse(res.body).length).to eq(8)
    end

    it 'should GET book by ID' do
      first_book_hsh = JSON.parse(subject.get_all_books.body)[0]
      bookID_str = first_book_hsh['_id']
      title = first_book_hsh['title']
      author = first_book_hsh['author']
      res = subject.get_book_by_id(bookID_str)
      expect(res.status).to eq(200)
      expect(JSON.parse(res.body)['title']).to eq(title)
      expect(JSON.parse(res.body)['author']).to eq(author)
    end

    it 'should GET books by author' do
      author_str = 'D. B. C. Quell'
      res = subject.request_books_by_author('D. B. C. Quell')
      body = JSON.parse(res.body)[0]
      expect(res.status).to eq(200)
      expect(body['title']).to eq("Make Mongo, Not SQL!")
      expect(body['author']).to eq(author_str)
    end
    #
    # it 'should GET books by author and title' do
    #   author_str = 'Foo Bar III'
    #   title_str = 'Hello, World!'
    #   res = subject.get_books_by_author_title(author_str, title_str)
    #   expect(res.count).to eq(3)
    # end
    #
    # it "should GET available books by author and title" do
    #   author_str = 'Foo Bar III'
    #   title_str = 'Hello, World!'
    #   res = subject.get_available_books_by_author_title(author_str, title_str)
    #   expect(res.count).to eq(1)
    # end
    #
    # it "should GET first available book by author and title" do
    #   author_str = 'Foo Bar III'
    #   title_str = 'Hello, World!'
    #   res = subject.get_first_available_book_by_author_title(author_str, title_str)
    #   puts res
    #   expect(res['author']).to eq(author_str)
    #   expect(res['title']).to eq(title_str)
    # end


    # it 'should POST a new book to the CpcLibrarian collection' do
    #   res = subject.post_book(new_book_hsh)
    #   expect(res.status).to eq(200)
    #   expect(JSON.parse(res.body)['title']).to eq(new_book_hsh[:title])
    #   expect(JSON.parse(res.body)['author']).to eq(new_book_hsh[:author])
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
    #   expect(res.status).to eq(200)
    #   expect(JSON.parse(res.body)['id']).to eq(id_to_delete)
    #   expect(subject.get_all_books.body.count).to eq(all_books.count - 1)
    # end

    # it 'should GET a book by ID' do
    #   book_hsh_ary = JSON.parse(File.read(new_books_json_path))
    #   last_book_hsh = book_hsh_ary[-2]
    #   bookID_str = subject.get_latest_book['_id']
    #   res = subject.get_book_by_id(bookID_str)
    #   expect(res.headers['x-powered-by']).to eq('Express')
    #   expect(JSON.parse(res.body)['_id']).to eq(bookID_str)
    #   expect(JSON.parse(res.body)['title']).to eq(last_book_hsh['title'])
    #   expect(JSON.parse(res.body)['author']).to eq(last_book_hsh['author'])
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
    #   expect(JSON.parse(res.body)['_id']).to eq(bookID_str)
    #   expect(JSON.parse(res.body)['title']).to eq(book_hsh[:title])
    #   expect(JSON.parse(res.body)['author']).to eq(book_hsh[:author])
    #
    #   puts "Title after PUT: #{subject.get_latest_book['title']}"
    # end
  end
end
