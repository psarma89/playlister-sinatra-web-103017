class Artist < ActiveRecord::Base
  has_many :songs
  has_many :genres, through: :songs

  def slug
    name_split = self.name.split(" ")
    name_split.map{|name| name.downcase}.join("-")
  end

  def self.find_by_slug(slug)
    artist_name = slug.split("-").join(" ")
    # song_name = slug_split.map{|name| name.capitalize}.join(" ")

    Artist.where("lower(name) = '#{artist_name}'").first
  end

end
