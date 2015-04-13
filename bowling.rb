class Game
  attr_reader :frames
  attr_accessor :score

  def initialize
    @frames = []
    @score = 0
    setup_frames
  end

  def update_score(score)
    @score += score
  end

  private
  def setup_frames
    (1..10).each do |i|
      @frames << Frame.new(i, self)
    end
  end
end

class Frame
  attr_reader :throws, :number
  attr_accessor :score

  def initialize(number, game)
    @number = number
    @game = game
    @throws = []
    @score = 0
    @left_pins = 10
    setup_throws
  end

  def update_score(score)
    @score += score
    @left_pins -= score
    @game.update_score(score)
  end

  def valid_score?(score)
    score <= @left_pins
  end

  def finished?
    if strike?
      puts "Strike!!!"
      true
    elsif two_throwed?
      if spare?
        puts "Spare!!!"
      end
      true
    else
      false
    end
  end

  private
  def setup_throws
    (1..2).each do |i|
      @throws << Throw.new(i, self)
    end
  end

  def strike?
    @throws.find{|t| t.number == 1}.score == 10
  end

  def spare?
    @throws.map(&:score).inject(&:+) == 10
  end

  def two_throwed?
    @throws.all?(&:score)
  end
end

class Throw
  attr_reader :score, :number

  def initialize(number, frame)
    @number = number
    @frame = frame
    @score = nil
  end

  def throw(score)
    if valid_score?(score)
      @score = score.to_i
      @frame.update_score(@score)
    else
      puts "Invalid Score!!!"
      false
    end
  end

  private
  def valid_score?(score)
    integer_string?(score) && score.to_i >=0 && @frame.valid_score?(score.to_i)
  end
end

def integer_string?(str)
  Integer(str)
  true
rescue ArgumentError
  false
end

puts "Hello, bowling!"

game = Game.new

game.frames.each do |frame|
  frame.throws.each do |throw|
    puts "This is a throw #{throw.number} in a frame #{frame.number}."
    begin
      puts "How many pins did you knocked down?"
      score = gets
    end until throw.throw(score)
    break if frame.finished?
  end
  puts "Current Score is #{game.score}!!!\n\n"
end

puts "Final Score is #{game.score}!!!"