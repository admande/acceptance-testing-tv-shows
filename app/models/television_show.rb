class TelevisionShow
  attr_reader :title, :network, :starting_year, :synopsis, :genre
  GENRES = ["Action", "Mystery", "Drama", "Comedy", "Fantasy"]

  def initialize(params={})
    @title = params[:title]
    @network = params[:network]
    @starting_year = params[:starting_year]
    @synopsis = params[:synopsis]
    @genre = params[:genre]
    @errors_array = []
  end

  def self.all
    shows = []
	    CSV.foreach("television-shows.csv", header_converters: :symbol, headers: true) do |show|
	      shows << show.to_h
	    end
	    shows.map do |show|
        TelevisionShow.new(show)
      end
	  end

  def errors
    @errors_array
  end

  def valid?
      flag = unique_title
      if !title.empty? && !network.empty? && !starting_year.empty? && !synopsis.empty?
          empty_flag = true
      else
        @errors_array << "Please fill in all required fields"
          empty_flag = false
      end
      empty_flag == false || flag == false ? false : true
  end

  def unique_title
    if
      !TelevisionShow.all.any? {|show| show.title == title}
      true
    else
      @errors_array << "The show has already been added"
      false
    end
   end

   def save
     if valid?
       CSV.open('television-shows.csv','a') do |file|
         file.puts([title, network, starting_year,synopsis,genre])
       end
       true
     else
       false
     end
   end
end
