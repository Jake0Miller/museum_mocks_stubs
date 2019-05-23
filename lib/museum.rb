
class Museum
  attr_reader :name, :exhibits, :patrons

  def initialize(name)
    @name = name
    @exhibits = []
    @patrons = []
  end

  def add_exhibit(exhibit)
    @exhibits << exhibit
  end

  def recommend_exhibits(patron)
    @exhibits.find_all do |exhibit|
      patron.interests.include?(exhibit.name)
    end
  end

  def admit(patron)
    @patrons << patron
  end

  def patrons_by_name
    @patrons.map do |patron|
      patron.name
    end
  end

  def average_exhibit_cost
    @exhibits.sum do |exhibit|
      exhibit.cost
    end/@exhibits.length
  end
end
