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
    recommended = []
    @exhibits.each do |exhibit|
      patron.interests.each do |interest|
        recommended << exhibit if exhibit.name == interest
      end
    end
    recommended
  end

  def admit(patron)
    @patrons << patron
  end

  def patrons_by_exhibit_interest
    exhibits_interest = Hash.new
    @exhibits.each do |exhibit|
      @patrons.each do |patron|
        exhibits_interest[exhibit] ||= []
        exhibits_interest[exhibit] << patron if patron.interests.include?(exhibit.name)
      end
    end
    exhibits_interest
  end
end
