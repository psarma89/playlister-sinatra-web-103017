require 'rack-flash'

class SongController < ApplicationController

  enable :sessions
  use Rack::Flash

  get '/songs' do
    @songs = Song.all
    erb :"/song/index"
  end

  get '/songs/new' do
    @genres = Genre.all
    erb :"/song/new"
  end

  post '/songs' do
    # binding.pry
    artist = Artist.find_or_create_by(name: params[:artist_name])
    @song = Song.create(name: params[:song_name])
    @song.artist = artist
    params[:genres].each do |genre|
      genre_instance = Genre.find(genre.to_i)
      genre_instance.songs << @song
      # @genre_instance.save
    end
    @song.save
    flash[:message] = "Successfully created song."
    redirect to "/songs/#{@song.slug}"
  end

  get '/songs/:slug' do
    @song = Song.find_by_slug(params[:slug])
    # binding.pry
    erb :"/song/show"
  end

  get '/songs/:slug/edit' do
    @song = Song.find_by_slug(params[:slug])
    @genres = Genre.all
    erb :"/song/edit"
  end

  patch '/songs/:slug' do
    # binding.pry
    @song = Song.find_by_slug(params[:slug])
    @song.name = params[:song_name]
    artist = Artist.find_or_create_by(name: params[:artist_name])
    @song.artist = artist

    params[:genres].each do |genre|
      genre_instance = Genre.find(genre.to_i)

      @song.song_genres.create(genre: genre_instance)
      # genre_instance.songs << @song
      # @genre_instance.save
    end

    @song.save
    flash[:message] = "Successfully updated song."
    redirect to "/songs/#{@song.slug}"
  end
end
