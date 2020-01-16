require 'bundler/setup'
require 'cpc'

module Contractor
  class CpcLibrary
    include Cpc::Util::ApiUtil

    def initialize(url, port_int)
      @host = [url, port_int].join(':')
    end

    def get_root
      args_hsh = { url: { host: @host } }
      api_get_request(args_hsh)
    end

    def get_all_books
      args_hsh = { url: { host: @host, path: 'book' } }
      api_get_request(args_hsh)
    end

    def get_book_by_id(bookID_str)
      args_hsh = { url: { host: @host, path: 'book', _id: bookID_str } }
      api_get_request(args_hsh)
    end

    def get_latest_book
      all_books = get_all_books.body.last
    end

    def post_book(book_hsh)
        request_body_uri = URI.encode(book_hsh.map {|k,v| "#{k}=#{v}"}.join('&'))
        args_hsh = {
          url: { host: @host, path: 'book' },
          request_body: request_body_uri
        }
      api_post_request(args_hsh)
    end

    def post_books(new_books_json_path)
      added_book_hsh_ary = []
      book_hsh_ary = JSON.parse(File.read(new_books_json_path))
      book_hsh_ary.each do |book_hsh|
        res = post_book(book_hsh)
        added_book_hsh_ary << res.body
      end
      added_book_hsh_ary
    end

    def delete_book(bookID_str)
      args_hsh = { url: { host: @host, path: 'book', book_id: bookID_str } }
      api_delete_request(args_hsh)
    end

    def delete_latest_book(protected_id_ary = nil)
      all_books = get_all_books.body
      deletable_books = all_books.reject { |h| protected_id_ary.include?(h['_id']) }
      deletable_ids = deletable_books.map { |h| h['_id'] }
      id_to_delete = deletable_ids.last
      delete_book(id_to_delete)
    end

    def delete_all_books
      book_hsh_ary = get_all_books.body
      id_ary = book_hsh_ary.map { |hsh| hsh['_id'] }
      id_ary.each { |bookID_str| delete_book(bookID_str) }
    end

    def put_book(book_hsh)
      request_body_uri = URI.encode(book_hsh.map {|k,v| "#{k}=#{v}"}.join('&'))
      args_hsh = {
        url: { host: @host, path: 'book', _id: book_hsh[:_id] },
        request_body: request_body_uri
      }
      api_put_request(args_hsh)
    end
  end
end
