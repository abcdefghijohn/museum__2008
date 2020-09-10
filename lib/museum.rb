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

  def ticket_lottery_contestants(exhibit)
    contestants = []
    patrons_by_exhibit_interest[exhibit].each do |patron|
      contestants << patron if patron.spending_money < exhibit.cost
    end
    contestants
  end

  def draw_lottery_winner(exhibit)
    if ticket_lottery_contestants(exhibit).sample
      winner = ticket_lottery_contestants(exhibit).sample
      winner.name
    elsif ticket_lottery_contestants(exhibit) == nil
      winner = nil
    end
  end

  def announce_lottery_winner(exhibit)
    name = draw_lottery_winner(exhibit)
    print "#{name} has won the IMAX exhibit lotter"
  end
end
