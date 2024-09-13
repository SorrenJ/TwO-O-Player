require_relative 'player'
require_relative 'question'

class Game
    attr_reader :player1, :player2, :current_player
  
    def initialize
      @player1 = Player.new("Player 1")
      @player2 = Player.new("Player 2")
      @current_player = @player1
    end
  
    def start
      puts "----- Welcome to the Math Game -----"
      until game_over?
        puts "----- NEW TURN -----"
        question = Question.new
        question.ask_question
  
        print "#{current_player.name}: > "
        answer = gets.chomp.to_i
  
        if question.correct_answer?(answer)
          puts "#{current_player.name}: YES! You are correct."
        else
          puts "#{current_player.name}: Seriously? No!"
          current_player.lose_life
        end
  
        display_scores
        switch_player
      end
  
      announce_winner
    end
  
    def switch_player
      @current_player = (@current_player == @player1) ? @player2 : @player1
    end
  
    def display_scores
      puts "P1: #{@player1.lives}/3 vs P2: #{@player2.lives}/3"
    end
  
    def game_over?
      !@player1.alive? || !@player2.alive?
    end
  
    def announce_winner
      winner = @player1.alive? ? @player1 : @player2
      puts "#{winner.name} wins with a score of #{winner.lives}/3"
      puts "----- GAME OVER -----"
      puts "Goodbye!"
    end
  end

