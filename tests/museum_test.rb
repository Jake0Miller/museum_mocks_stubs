require 'minitest/autorun'
require 'minitest/pride'
require 'mocha/minitest'
require './lib/museum'

class MuseumTest <Minitest::Test

  def test_it_exists
    dmns = Museum.new("Denver Museum of Nature and Science")
    assert_instance_of Museum, dmns
  end

  def test_it_has_attributes
    dmns = Museum.new("Denver Museum of Nature and Science")

    assert_equal "Denver Museum of Nature and Science", dmns.name
    assert_equal [], dmns.exhibits
  end

  def test_it_can_add_exhibits
    gems_and_minerals = mock("Gems and Minerals")
    dead_sea_scrolls = mock("Dead Sea Scrolls")
    imax = mock("IMAX")
    dmns = Museum.new("Denver Museum of Nature and Science")
    dmns.add_exhibit(gems_and_minerals)
    dmns.add_exhibit(dead_sea_scrolls)
    dmns.add_exhibit(imax)

    assert_equal [gems_and_minerals,dead_sea_scrolls,imax], dmns.exhibits
  end


  def test_patrons_starts_empty
    dmns = Museum.new("Denver Museum of Nature and Science")

    assert_equal [], dmns.patrons
  end

  def test_it_can_admit_patrons
    dmns = Museum.new("Denver Museum of Nature and Science")

    bob = mock("Bob")
    sally = mock("Sally")

    dmns.admit(bob)
    dmns.admit(sally)

    assert_equal [bob,sally], dmns.patrons
  end

  def test_it_can_list_admitted_patrons_by_name
    dmns = Museum.new("Denver Museum of Nature and Science")

    bob = stub(name: "Bob", age: 20)
    sally = stub(name: "Sally", age: 20)

    dmns.admit(bob)
    dmns.admit(sally)

    assert_equal ["Bob","Sally"], dmns.patrons_by_name
  end

  def test_it_can_tell_you_the_average_exhibit_cost
    dmns = Museum.new("Denver Museum of Nature and Science")
    gems_and_minerals = stub(name: "Gems and Minerals", cost: 4)
    dead_sea_scrolls = stub(name: "Dead Sea Scrolls", cost: 11)
    imax = stub(name: "IMAX", cost: 15)
    dmns.add_exhibit(gems_and_minerals)
    dmns.add_exhibit(dead_sea_scrolls)
    dmns.add_exhibit(imax)

    assert_equal 10, dmns.average_exhibit_cost
  end

  def test_there_are_recommended_exhibits_for_a_given_patron
    gems_and_minerals = stub(name: "Gems and Minerals", cost: 0)
    dead_sea_scrolls = stub(name: "Dead Sea Scrolls", cost: 10)
    imax = stub(name: "IMAX", cost: 15)
    dmns = Museum.new("Denver Museum of Nature and Science")
    dmns.add_exhibit(gems_and_minerals)
    dmns.add_exhibit(dead_sea_scrolls)
    dmns.add_exhibit(imax)

    bob = stub(name: "Bob", age: 20, interests: [])
    bob.interests << "Dead Sea Scrolls"
    bob.interests << "Gems and Minerals"

    #bob.add_interest("Dead Sea Scrolls")
    #bob.add_interest("Gems and Minerals")

    sally = stub(name: "Sally", age: 20, interests: [])
    sally.interests << "IMAX"
    #sally.add_interest("IMAX")

    assert_equal [gems_and_minerals,dead_sea_scrolls], dmns.recommend_exhibits(bob)
    assert_equal [imax], dmns.recommend_exhibits(sally)
  end

end
