require 'rubygems'

#It has a problem on the following line for unknown reasons
require 'sinatra'
# The next line is not a problem
require 'sinatra/reloader'
require 'rainbow'
require 'pg'

get '/' do
  erb :root
end

get '/contacts' do
  db = PG.connect(:dbname => 'address book',
                  :host => 'localhost',
                  :user => 'postgres',
                  :password => 'postgres')
  sql = "select * from contacts2"
  @contacts = db.exec(sql)
  db.close
  erb :contacts
end

get '/contacts/new' do
  erb :contact_new
end

post '/contacts' do
  db = PG.connect(
      :dbname => 'address book',
      :host => 'localhost',
      :password => 'postgres',
      :user => 'postgres')
  @first = params[:first]
  @last = params[:last]
  @age = params[:age].to_i
  @gender = params[:gender]
  sql = "insert into contacts2 (first,last,age,gender) values ('#{@first}', '#{@last}', #{@age} , '#{@gender}')"
  db.exec(sql)
  db.close
  redirect to "/contacts"
end

#show one specific contact/name
get '/contacts/:name' do
  @name = params[:name]
  db = PG.connect(:dbname => 'address book',
                  :host => 'localhost',
                  :user => 'postgres',
                  :password => 'postgres')
  sql = "select * from contacts2 where first = '#{@name}'"
  @contact = db.exec(sql).first #otherwise it will return an array of size 1
  db.close

  erb :contact
end