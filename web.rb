require 'rubygems'
require 'sinatra'
require 'make_todo'

get '/?' do  
  @items = Tarea.all
  redirect '/new' if @items.empty?
  erb :index
end

get '/new/?' do
  @title = "Add todo item"
  erb :new
end

post '/new/?' do
  Tarea.create(params[:content])  
  redirect '/'
end

post '/done/?' do
  Tarea.update(params[:id]) 
  @tareaupd = Tarea.find(params[:id])
  content_type 'application/json'
  value = @tareaupd["done"] ?  'Done' : 'Not Done'
  { :id => params[:id], :status => value }.to_json 
end

get '/delete/:id/?' do
  @tareadel = Tarea.find(params[:id])
  erb :delete
end

post '/delete/:id/?' do
  if params.has_key?("ok")    
    Tarea.destroy(params[:id])
    redirect '/'
  else
    redirect '/'
  end
end