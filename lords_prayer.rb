# lords_prayer.rb

# Our Father who art in heaven, hallowed be thy name. 
# Thy kingdom come. Thy will be done on earth as it is in heaven. 
# Give us this day our daily bread, and forgive us our trespasses, 
# as we forgive those who trespass against us, 
# and lead us not into temptation, 
# but deliver us from evil.

# For thine is the kingdom
#  and the power, 
#  and the glory, 
#  forever and ever.

# Amen.

require 'date'
require 'ostruct'


class Tresspass
    attr_accessor :perp, :victim
    def initialize perp: nil, victim: nil, forgiven: false
        @perp = perp
        @victim = victim
        @forgiven = forgiven
    end

    def forgiven?
        @forgiven
    end

    def forgive!
        @forgiven = true
    end
end


class Deity
    attr_accessor :name, :location, :will, :possessions
    
     def initialize name: nil, who_art_in: nil
       @name = name
       @location = who_art_in
       @will = { "Heaven" => Will.new(:done),
                 "Earth"  => Will.new(:started) }
       @possessions = []
     end
 
    def begat entity
        entity.parents << self
    end 

end

class Bread
end

class Possession 
    def initialize item:, interval: 
        @item = item
        @interval = interval
    end
end

class Person
    attr_accessor :place, :name, :gender, :possessions, :parents, :tresspasses

    def initialize(parents: [], name: nil, place: nil, gender: nil)
        @name = name
        @place = place
        @parents = parents
        @gender = gender
        @stash = []
        @tresspasses = []
        @possessions = []
    end

    def father 
        @parents.detect {|p| [:male, :transcendent].include? p.gender }
    end

    def begat entity
        entity.parents << self
    end 

    def my_trespasses
        @tresspasses.select { |t| t.perp == self }
    end

    def those_who_tresspassed_against_me
        @tresspasses.select { |t| t.victim == self }
    end

    def say *words 
        puts "#{name} says:  #{words.join(' ')}"
    end
end

class LordOurGod < Deity
    attr_accessor :name, :place

    def forgive tresspass
        tresspass.forgive!
    end

    def deliver_us_from_evil person
        Evil.delete(person)
    end

    def gender
        :transcendent
    end
end

class Place
  def initialize name: nil, location: nil
    @name = name
    @location = location
  end
end


Heaven = Place.new(name: 'Heaven', location: 'Astral Plane')
Earth = Place.new(name: 'Earth', location: 'Firmament')
class Hell < Exception ; end

class Will
    STATES = [:unstarted, :started, :done]
    def initialize state
        raise Hell unless STATES.include?(state)
        @state = state
    end
end

God = LordOurGod.new who_art_in: Heaven

Me   = Person.new place: Earth, name: 'Paul', gender: :male
Adam = Person.new place: Earth, name: 'Adam', gender: :male
Eve  = Person.new place: Earth, name: 'Eve',  gender: :female
I = Me

People = [Me, Adam, Eve]

God.begat Me
God.begat Adam
God.begat Eve

forever_and_ever = ((Date.today)..) 

def People.say *words
    each {|p| p.say *words }
end 

our_father = People.map(&:father).uniq.tap {|fathers| raise Hell unless fathers.count == 1 }.first

our_father.name = 'Hallowed'

Kingdom = [Heaven]

Temptation = [] 
Evil = []

rapture_day = Date.today + rand(10)
forever_and_ever.each do |this_day|
    People.each do |person|
        person.possessions << Bread.new
        my_bad, their_bads = person.tresspasses.partition { |p| p.perp == Me }
        my_bad.each { |t| our_father.forgive! t }
        their_bads.each { |t| forgive! t}
        # Temptation << person
        People.each { |p| our_father.deliver_us_from_evil p }
    end
    if this_day == rapture_day
        Kingdom << Earth
        our_father.will["Earth"] = our_father.will["Heaven"]
        break
    end
end

Power=OpenStruct.new( type: "Power", level: 11 )
Glory=OpenStruct.new( type: "Glory", level: 11 )
our_father.possessions << Possession.new(item: Kingdom, interval: forever_and_ever)
our_father.possessions << Possession.new(item: Power, interval: forever_and_ever)
our_father.possessions << Possession.new(item: Glory, interval: forever_and_ever)

People.say "amen"

pp our_father

pp People