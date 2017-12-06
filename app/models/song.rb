class Song < ActiveRecord::Base
  belongs_to :artist
  has_many :song_genres
  has_many :genres, through: :song_genres

  def slug
    name_split = self.name.split(" ")
    name_split.map{|name| name.downcase}.join("-")
  end

  def self.find_by_slug(slug)
    song_name = slug.split("-").join(" ")
    # song_name = slug_split.map{|name| name.capitalize}.join(" ")

    Song.where("lower(name) = '#{song_name}'").first
  end

end
