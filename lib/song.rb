require "pry"

class Song
  attr_accessor :name, :artist_name
  @@all = []

  def initialize(name = "")
    @name = name
  end

  def self.all
    @@all
  end

  def save
    self.class.all << self
  end

  def self.create
    new_song = self.new
    new_song.save
    new_song
  end

  def self.new_by_name(name)
    new_song = self.new(name)
  end

  def self.create_by_name(name)
    new_song = self.new(name)
    new_song.save
    new_song
  end

  def self.find_by_name(name)
    @@all.find { |song| song.name == name }
  end

  def self.find_or_create_by_name(name)
    song = self.find_by_name(name)
    if !song
      song = self.create_by_name(name)
    end
    song
  end

  def self.alphabetical
    @@all.sort { |a, b| a.name <=> b.name }
  end

  def self.new_from_filename(filename)
    filesplit = filename.split(" - ", 2)
    song = self.new_by_name(filesplit[1].delete_suffix(".mp3"))
    song.artist_name = filesplit[0]
    song
  end

  def self.create_from_filename(filename)
    filesplit = filename.split(" - ", 2)
    song = self.create_by_name(filesplit[1].delete_suffix(".mp3"))
    song.artist_name = filesplit[0]
    song
  end

  def self.destroy_all
    @@all.clear
  end
end
