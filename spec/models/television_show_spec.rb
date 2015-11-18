require "spec_helper"
require 'pry'
describe TelevisionShow do
  let(:show) { TelevisionShow.new(params={title: "Friends",network: "NBC",starting_year: "1994",synopsis: "6 friends living in the city",genre: "Comedy"})}
  let(:show2) { TelevisionShow.new(params={title: "Enemies",network: "NBC",starting_year: "1994",synopsis: "6 friends living in the city",genre: "Comedy"})}
  let(:error_show) { TelevisionShow.new(params={title: "",network: "NBC",starting_year: "1994",synopsis: "6 friends living in the city",genre: "Comedy"})}
  let(:duplicate_show) { TelevisionShow.new(params={title: "Friends",network: "NBC",starting_year: "1994",synopsis: "6 friends living in the city",genre: "Comedy"})}
  let(:unique_show) { TelevisionShow.new(params={title: "Clams",network: "CBS",starting_year: "1984",synopsis: "6 clams living in the city",genre: "Comedy"})}
  let(:double_bad_show) { TelevisionShow.new(params={title: "Friends",network: "",starting_year: "1984",synopsis: "6 clams living in the city",genre: "Comedy"})}

  describe ".new" do
    it "should initialize a new television show" do
      expect(show).to be_a(TelevisionShow)
    end
  end

  describe "#title" do
    it "should display the title of the show" do
      expect(show.title).to eq("Friends")
    end
  end

  describe "#network" do
    it "should display the network of the show" do
      expect(show.network).to eq("NBC")
    end
  end

  describe ".all" do
    before(:each) do
      CSV.open('television-shows.csv', 'a') do |file|
        title = "Friends"
        network = "NBC"
        starting_year = "1994"
        synopsis = "Six friends living in New York city"
        genre = "Comedy"
        data = [title, network, starting_year, synopsis, genre]
        file.puts(data)
      end
      CSV.open('television-shows.csv', 'a') do |file|
        title = "Enemies"
        network = "ABC"
        starting_year = "1996"
        synopsis = "Six enemies living in New York city"
        genre = "Drama"
        data = [title, network, starting_year, synopsis, genre]
        file.puts(data)
      end
    end

    it "should return an array of all the tv shows" do
      expect(TelevisionShow.all).to be_a(Array)


    end

    it "should have objects in the array" do
      TelevisionShow.all.each do |tv|
        expect(tv).to be_a TelevisionShow
        expect(tv.title).to_not be_nil
      end
      expect(TelevisionShow.all[0]).to be_a(TelevisionShow)
      expect(TelevisionShow.all[0].title).to eq("Friends")
      expect(TelevisionShow.all.size).to eq(2)
    end
  end

  describe "errors" do
    it "should return an empty array on a new object that is initialized correctly" do
      expect(show.errors).to be_a(Array)
    end
  end

  describe "#valid" do
    it "should leave errors as an empty array if all fields are filled out" do
      show.valid?
      expect(show.errors.empty?).to be(true)
    end

    it "should put an error in the error array if the fields are not all filled out" do
      error_show.valid?
      expect(error_show.errors.empty?).to be(false)
      expect(error_show.errors).to eq(["Please fill in all required fields"])
    end
  end

  describe "#unique_title" do
    before(:each) do
      CSV.open('television-shows.csv', 'a') do |file|
        title = "Friends"
        network = "NBC"
        starting_year = "1994"
        synopsis = "Six friends living in New York city"
        genre = "Comedy"
        data = [title, network, starting_year, synopsis, genre]
        file.puts(data)
      end
      CSV.open('television-shows.csv', 'a') do |file|
        title = "Friends"
        network = "ABC"
        starting_year = "1996"
        synopsis = "Six enemies living in New York city"
        genre = "Drama"
        data = [title, network, starting_year, synopsis, genre]
        file.puts(data)

      end
      TelevisionShow.all
    end
    it "should not raise an error for a show that is not already there" do
      unique_show.unique_title
      expect(unique_show.errors.empty?).to eq(true)
    end

    it "should raise an error for a show that is not unique" do
      duplicate_show.unique_title
      expect(duplicate_show.errors).to eq(["The show has already been added"])
    end

    it "should have both errors for a duplicate title with missing fields" do
      double_bad_show.valid?
      expect(double_bad_show.errors).to eq(["The show has already been added","Please fill in all required fields"])
    end
  end

  describe "#save" do
    before(:each) do
      CSV.open('television-shows.csv', 'a') do |file|
        title = "Friends"
        network = "NBC"
        starting_year = "1994"
        synopsis = "Six friends living in New York city"
        genre = "Comedy"
        data = [title, network, starting_year, synopsis, genre]
        file.puts(data)
      end
      CSV.open('television-shows.csv', 'a') do |file|
        title = "Other Show"
        network = "ABC"
        starting_year = "1996"
        synopsis = "Six enemies living in New York city"
        genre = "Drama"
        data = [title, network, starting_year, synopsis, genre]
        file.puts(data)

      end
      TelevisionShow.all
    end

    it "should return true for a valid show" do
      expect(unique_show.save).to eq(true)
      expect(double_bad_show.save).to eq(false)
    end
  end
end
