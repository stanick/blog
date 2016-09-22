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
  db = init_db
  @results = db.execute 'select * from posts order by id desc' 
  erb :posts			
end

get '/new' do
	erb :new			
end

post '/new' do
   post = params[:post]
  db = init_db
  db.execute 'insert into posts (content, date_added)
			  values (?, datetime())', [post] 
  redirect to '/'
end