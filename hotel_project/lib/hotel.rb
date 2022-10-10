require_relative "room"

class Hotel

  attr_reader :rooms
  
  def initialize(name, hsh)
    @name = name
    @rooms = Hash.new
    hsh.each {|room_name,cap| @rooms[room_name] = Room.new(cap)}
  end

  def name
    words = @name.split(" ")
    words.map! {|word| word.capitalize}
    return words.join(" ")
  end

  def room_exists?(room_name)
    return @rooms[room_name] != nil
  end

  def check_in(person, room_name)
    if room_exists?(room_name)
        if @rooms[room_name].add_occupant(person)
            puts "check in successful"
        else
            puts "sorry, room is full"
        end
    else
        puts "sorry, room does not exist"
    end
  end

  def has_vacancy?
    return !@rooms.values.all? {|room| room.full? }
  end

  def list_rooms
    @rooms.each do |name, room|
        puts name + " : " + room.available_space.to_s
    end
  end

end
