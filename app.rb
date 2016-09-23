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

db.execute 'create table if not exists comments 
		(
		id integer primary key autoincrement,
		content text,
		date_added date,
		post_id integer
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

get '/post/:id' do
    @post_id = params[:id]
    db = init_db
    post = db.execute 'select * from posts where id = ?', [@post_id] 
    @post = post[0]

    @comments = db.execute 'select * from comments where post_id = ? order by id desc', [@post_id] 

    erb :comments			
end

post '/post/:id' do
  @post_id = params[:id]
  post = params[:post]
  db = init_db
  db.execute 'insert into commnts (content, date_added, post_id)
			  values (?, datetime(), ?)', [post, @post_id] 
  erb :comments			

end
