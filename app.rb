require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sqlite3'

def init_db
db = SQLite3::Database.new 'blog.db'
db.results_as_hash = true
return db
end

configure do
db = init_db
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
   post = params[:post]
  db = init_db
  db.execute 'insert into posts (content, date_added)
			  values (?, datetime())', [post] 
  erb :new
end