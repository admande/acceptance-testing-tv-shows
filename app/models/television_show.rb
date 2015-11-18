class TelevisionShow
  attr_reader :title, :network, :starting_year, :synopsis, :genre
  GENRES = ["Action", "Mystery", "Drama", "Comedy", "Fantasy"]

  def initialize(params={})
    @title = params[:title]
    @network = params[:network]
    @starting_year = params[:starting_year]
    @synopsis = params[:synopsis]
    @genre = params[:genre]
  end

  def self.all
    shows = []
	    CSV.foreach("television-shows.csv", headers: true) do |show|
	      shows << show
	    end
	    shows.map { |show| TelevisionShow.new(show) }
      
	  end
end
