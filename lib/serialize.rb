module Serialize
  def save_game
    Dir.mkdir 'saved_files' unless Dir.exists? 'saved_files'
    @filename = "#{saved_name}.yaml"
    File.open("saved_files/#{@filename}", 'w') { |file| file.write(save_to_yaml) }
  end

  def save_to_yaml
    YAML.dump(
      'player1' => @player1,
      'player2' => @player2,
      'board' => @board,
      'current_player' => @current_player
    )
  end

  def saved_name
    nouns = %w[monkey bird girl camera man person computer lamp bottle desk]
    adj = %w[big smelly tall nice mean itchy beautiful ugly angry wet]
    "#{adj[rand(10)]}_#{nouns[rand(10)]}_#{rand(100)}"
  end

  def load_game_file
    data = YAML.safe_load(File.read(@selection),
                          permitted_classes: [Rook, Knight, Bishop, Queen, King, Pawn, Piece,
                                             Pieces, Checkfinder, Checkmate, Evaluation, Movement, Display, 
                                             Player, Board, Game, ColorableString],
                          aliases: true)
    @player1 = data['player1']
    @player2 = data['player2']
    @board = data['board']
    @current_player = data['current_player']
  end

  def select_game_file
    input = gets.chomp.to_i
    @selection = @file_arr[input - 1]
  end

  # Create view for user to see list of files they can chose from
  def find_game_file
    @file_arr = Dir.glob('saved_files/*.yaml')
    puts 'Available Game Files:'
    @file_arr.each_with_index do |file, i|
      puts "#{i + 1}: #{file.split('/')[1]}"
    end
    print "\nEnter a file number: "
  end

  def load_game
    find_game_file
    select_game_file
    load_game_file
    play_game
    File.delete(@selection) if File.exist?(@selection)
  end
end