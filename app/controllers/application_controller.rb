class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  # Index Action
  get '/' do
    erb :index
  end
  get '/recipes' do
    @recipes = Recipe.all
    erb :index
  end

  # New Action
  get '/recipes/new' do
    erb :new
  end
  post '/recipes' do
    attributes = {name: params[:name], ingredients: params[:ingredients], cook_time: params[:cook_time]}
    @recipe = Recipe.create(attributes)
    @recipe.save
    redirect to "/recipes/#{@recipe.id}"
  end

  # Edit Action
  get '/recipes/:id/edit' do
    @recipe = Recipe.find_by_id(params[:id])
    erb :edit
  end
  patch '/recipes/:id' do
    attributes = {name: params[:name], ingredients: params[:ingredients], cook_time: params[:cook_time]}
    @recipe = Recipe.find_by_id(params[:id])
    @recipe.update(attributes)
    @recipe.save
    redirect to "/recipes/#{@recipe.id}"
  end

  # Delete Action
  delete '/recipes/:id/delete' do
    @recipe = Recipe.find_by_id(params[:id])
    @recipe.destroy
    redirect to '/recipes'
  end

  # Show Action
  get '/recipes/:id' do
    @recipe = Recipe.find_by_id(params[:id])
    erb :show
  end

end
