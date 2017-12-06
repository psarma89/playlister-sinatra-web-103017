class Genre < ActiveRecord::Base
  has_many :song_genres
  has_many :songs, through: :song_genres
  has_many :artists, through: :songs

  def slug
    name_split = self.name.split(" ")
    name_split.map{|name| name.downcase}.join("-")
  end

  def self.find_by_slug(slug)
    genre_name = slug.split("-").join(" ")
    # song_name = slug_split.map{|name| name.capitalize}.join(" ")

    Genre.where("lower(name) = '#{genre_name}'").first
  end

end
