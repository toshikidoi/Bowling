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
    setup_throws
  end

  def update_score(score)
    @score += score
    @game.update_score(score)
  end

  private
  def setup_throws
    (1..2).each do |i|
      @throws << Throw.new(i, self)
    end
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
    @score = score
    @frame.update_score(score)
  end
end

puts "Hello, bowling!"

game = Game.new

game.frames.each do |frame|
  frame.throws.each do |throw|
    puts "This is a throw #{throw.number} in a frame #{frame.number}."
    puts "How many pins did you knocked down?"
    score = gets.to_i
    throw.throw(score)
  end
  puts "Current Score is #{game.score}!!!\n\n"
end

puts "Final Score is #{game.score}!!!"