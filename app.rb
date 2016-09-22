require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sqlite3'

def init_db
SQLite3::Database.new 'blog.db'
end

configure do
db = init_db
db.results_as_hash = true
db.execute 'create table if not exists posts 
		(
		id integer primary key autoincrement,
		content text,
		date_added date
		)'
end

get '/' do
	erb "Hello! <a href=\"https://github.com/bootstrap-ruby/sinatra-bootstrap\">Original</a> pattern has been modified for <a href=\"http://rubyschool.us/\">Ruby School</a>"			
end

get '/new' do
	erb :new			
end

post '/new' do
  erb "Hello World"
end