require "spec_helper"

describe TelevisionShow do
  let(:show) { TelevisionShow.new(params={title: "Friends",network: "NBC",starting_year: "1994",synopsis: "6 friends living in the city",genre: "Comedy"})}
  let(:show2) { TelevisionShow.new(params={title: "Enemies",network: "NBC",starting_year: "1994",synopsis: "6 friends living in the city",genre: "Comedy"})}
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

  # describe ".all" do
  #   let(:all) {TelevisionShow.all}
  #   it "should return an array of all the tv shows" do
  #     expect(all).to be_a(Array)
  #
  #   end
  #   it "should have objects in the array" do
  #     expect(shows).to be_a(TelevisionShow)
  #   end
end
