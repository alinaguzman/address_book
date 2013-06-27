require 'sinatra'
require 'sinatra/reloader'
require 'pg'

get '/' do
  db = PG.connect(
      :dbname => 'address book',
      :host => 'localhost',
      :password => 'postgres',
      :user => 'postgres')
  @first = params[:first]
  @last = params[:last]
  @age = params[:age]
  @gender = params[:gender]
  sql = "insert into contacts2 (first,last,age,gender) values ('#{@first}', '#{@last}', #{@age} , '#{@gender}')"
  db.exec(sql)
  db.close

  erb :root
end