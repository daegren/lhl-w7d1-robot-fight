require_relative 'robot'
require_relative 'turn_manager'

# Only this class (and main) will be "allowed" to call puts
class Game

  def initialize
    robot1 = Robot.new('Bender')
    robot2 = Robot.new('Wall-E')
    robot3 = Robot.new('Karen (From SpongeBob, aka Plankton\'s wife)')

    @robots = [robot1, robot2, robot3]
    @turn_manager = TurnManager.new(@robots)
  end

  # This method will handle the main game loop
  def play
    while (not game_over?)
      turn = @turn_manager.next_turn(alive_robots)

      header "Round #{turn.round_number}"

      puts "#{turn.attacker.name} is attacking #{turn.defender.name}!"

      amount = turn.attacker.attack turn.defender

      puts "#{turn.attacker.name} does #{amount} damage!"

      header "Summary"

      puts game_summary

      sleep 0.75
    end
  end

  # methods declared after here will be marked as "private" 
  # i.e. they are not available outside of this class
  private

  def alive_robots
    @robots.filter { |r| not r.dead? }
  end

  def game_over?
    alive_robots.count == 1
  end

  def header(message)
    puts
    puts "===== #{message} ====="
    puts
  end

  def game_summary
    @robots.map { |r| r.summary }.join("\n")
  end
  
end
