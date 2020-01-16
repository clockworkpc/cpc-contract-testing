# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Contractor::CpcLibrary do
  let(:new_books_json_path) { 'spec/fixtures/new_books.json' }

  context 'on Port 4001', online: true do
    url = 'http://localhost'
    port = 4001
    subject = Contractor::CpcLibrary.new(url, port)

    before(:all) do
      subject.delete_all_books
    end

    new_book_hsh = {
      title: 'Hello, World, Yet Again!',
      author: 'Foo Bar III'
    }

    it 'should GET root page' do
      res = subject.get_root
      expect(res.code).to eq(200)
      expect(res.body).to eq("Welcome to the CPC Library on MongoDB, available at Port #{port}")
      expect(res.headers['x-powered-by']).to eq('Express')
    end

    it 'should POST a new book to the CpcLibrary collection' do
      res = subject.post_book(new_book_hsh)
      expect(res.code).to eq(200)
      expect(res.body['title']).to eq(new_book_hsh[:title])
      expect(res.body['author']).to eq(new_book_hsh[:author])
    end

    it 'should POST a collection of new books from JSON' do
      book_hsh_ary = JSON.parse(File.read(new_books_json_path))
      res = subject.post_books(new_books_json_path)
      expect(res.count).to eq(book_hsh_ary.count)
    end

    it 'should GET all the books in the CPCLibrary collection' do
      res = subject.get_all_books
      expect(res.code).to eq(200)
      expect(res.body[0]['title']).to eq(new_book_hsh[:title])
      expect(res.body[0]['author']).to eq(new_book_hsh[:author])
      expect(res.body.count).to eq(7)
    end

    it 'should DELETE the latest book in the collection' do
      protected_id_ary = ['5e20e90380c9c830e74c6335']

      all_books = subject.get_all_books.body
      deletable_books = all_books.reject { |h| protected_id_ary.include?(h['_id']) }
      deletable_ids = deletable_books.map { |h| h['_id'] }
      expect(deletable_ids.count).to eq(all_books.count)
      id_to_delete = deletable_ids.last

      res = subject.delete_latest_book(protected_id_ary)
      expect(res.code).to eq(200)
      expect(res.body['id']).to eq(id_to_delete)
      expect(subject.get_all_books.body.count).to eq(all_books.count - 1)
    end

    it 'should GET a book by ID' do
      book_hsh_ary = JSON.parse(File.read(new_books_json_path))
      last_book_hsh = book_hsh_ary[-2]
      bookID_str = subject.get_latest_book['_id']
      res = subject.get_book_by_id(bookID_str)
      expect(res.headers['x-powered-by']).to eq('Express')
      expect(res.body['_id']).to eq(bookID_str)
      expect(res.body['title']).to eq(last_book_hsh['title'])
      expect(res.body['author']).to eq(last_book_hsh['author'])
    end

    it 'should PUT a book by ID' do
      book_hsh_ary = JSON.parse(File.read(new_books_json_path))
      last_book_hsh = book_hsh_ary[-2]
      bookID_str = subject.get_latest_book['_id']
      book_hsh = {
        _id: bookID_str,
        title: 'No True Highlander',
        author: 'Hamish MacDonald'
      }

      puts "Title before PUT: #{subject.get_latest_book['title']}"

      res = subject.put_book(book_hsh)
      expect(res.headers['x-powered-by']).to eq('Express')
      expect(res.body['_id']).to eq(bookID_str)
      expect(res.body['title']).to eq(book_hsh[:title])
      expect(res.body['author']).to eq(book_hsh[:author])

      puts "Title after PUT: #{subject.get_latest_book['title']}"
    end

    # it 'should PUT a contact by ID' do
    #   id_str = '5e1fda38e2f0747c7c67a952'
    #
    #   put1_contact_hsh = {
    #     _id: id_str,
    #     christianName: 'John',
    #     surname: 'Doe',
    #     email: 'johndoe@test.com',
    #     company: 'Foo Bar Pty Ltd',
    #     phone: 123_456_789
    #   }
    #
    #
    #   put2_contact_hsh = {
    #     _id: id_str,
    #     christianName: 'Hamish',
    #     surname: 'MacDonald',
    #     email: 'hamishmacdonald@test.com',
    #     company: 'Bar Foo Pty Ltd',
    #     phone: 987_654_321
    #   }
    #
    #   res1 = subject.put_contact(put1_contact_hsh)
    #   expect(res1.code).to eq(200)
    #   expect(res1.body['_id'].length).to eq(24)
    #   expect(res1.body['christianName']).to eq(put1_contact_hsh[:christianName])
    #   expect(res1.body['surname']).to eq(put1_contact_hsh[:surname])
    #   expect(res1.body['email']).to eq(put1_contact_hsh[:email])
    #   expect(res1.body['company']).to eq(put1_contact_hsh[:company])
    #   expect(res1.body['phone']).to eq(put1_contact_hsh[:phone])
    #   expect(res1.headers['x-powered-by']).to eq('Express')
    #
    #   res1.body.each {|k,v| puts "#{k}: #{v}"}
    #
    #   res2 = subject.put_contact(put2_contact_hsh)
    #   expect(res2.code).to eq(200)
    #   expect(res2.body['_id'].length).to eq(24)
    #   expect(res2.body['christianName']).to eq(put2_contact_hsh[:christianName])
    #   expect(res2.body['surname']).to eq(put2_contact_hsh[:surname])
    #   expect(res2.body['email']).to eq(put2_contact_hsh[:email])
    #   expect(res2.body['company']).to eq(put2_contact_hsh[:company])
    #   expect(res2.body['phone']).to eq(put2_contact_hsh[:phone])
    #   expect(res2.headers['x-powered-by']).to eq('Express')
    #
    #   res2.body.each {|k,v| puts "#{k}: #{v}"}
    # end
    #
    # it 'should DELETE the latest_contact contact' do
    #   protected_id_ary = ['5e1fd536e2f0747c7c67a949', '5e1fda38e2f0747c7c67a952']
    #
    #   all_contacts = subject.get_all_contacts.body
    #   deletable_contacts = all_contacts.reject { |h| protected_id_ary.include?(h['_id']) }
    #   deletable_ids = deletable_contacts.map { |h| h['_id'] }
    #   expect(deletable_ids.count).to eq(all_contacts.count - 2)
    #   id_to_delete = deletable_ids.last
    #
    #   res = subject.delete_latest_contact(protected_id_ary)
    #   expect(res.code).to eq(200)
    #   expect(res.body["id"]).to eq(id_to_delete)
    # end
  end
end
