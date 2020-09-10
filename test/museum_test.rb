require 'minitest/autorun'
require 'minitest/pride'
require './lib/patron'
require './lib/exhibit'
require './lib/museum'

class  MuseumTest <  Minitest::Test
  def test_it_exists_and_has_attributes
    dmns = Museum.new("Denver Museum of Nature and Science")

    assert_instance_of Museum, dmns
    assert_equal "Denver Museum of Nature and Science", dmns.name
  end

  def test_it_can_add_exhibits
    dmns = Museum.new("Denver Museum of Nature and Science")

    assert_equal [], dmns.exhibits

    gems_and_minerals = Exhibit.new({name: "Gems and Minerals", cost: 0})
    dead_sea_scrolls = Exhibit.new({name: "Dead Sea Scrolls", cost: 10})
    imax = Exhibit.new({name: "IMAX",cost: 15})

    dmns.add_exhibit(gems_and_minerals)
    dmns.add_exhibit(dead_sea_scrolls)
    dmns.add_exhibit(imax)

    expected = [gems_and_minerals, dead_sea_scrolls, imax]
    assert_equal expected, dmns.exhibits
  end

  def test_museum_can_recommend_exhibits
    dmns = Museum.new("Denver Museum of Nature and Science")
    gems_and_minerals = Exhibit.new({name: "Gems and Minerals", cost: 0})
    dead_sea_scrolls = Exhibit.new({name: "Dead Sea Scrolls", cost: 10})
    imax = Exhibit.new({name: "IMAX",cost: 15})
    patron_1 = Patron.new("Bob", 20)
    patron_2 = Patron.new("Sally", 20)

    dmns.add_exhibit(gems_and_minerals)
    dmns.add_exhibit(dead_sea_scrolls)
    dmns.add_exhibit(imax)

    patron_1.add_interest("Dead Sea Scrolls")
    patron_1.add_interest("Gems and Minerals")
    patron_2.add_interest("IMAX")

    expected = [dead_sea_scrolls, gems_and_minerals]
    assert_equal expected, dmns.recommend_exhibits(patron_1)
    assert_equal [imax], dmns.recommend_exhibits(patron_2)
  end
end
