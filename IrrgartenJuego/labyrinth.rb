class Labyrinth
  BLOCK_CHAR = 'X'
  EMPTY_CHAR = '-'
  MONSTER_CHAR = 'M'
  COMBAT_CHAR = 'C'
  EXIT_CHAR = 'E'
  ROW = 0
  COL = 1

  def initialize(nRows, nCols, exitRow, exitCol)
    @n_rows = nRows.to_i
    @n_cols = nCols.to_i
    @exit_col = exitCol.to_i
    @exit_row = exitRow.to_i

    @monsters = Array.new(@n_rows) { Array.new(@n_cols, nil) }
    @players = Array.new(@n_rows) { Array.new(@n_cols, nil) }
    @labyrinth = Array.new(@n_rows) { Array.new(@n_cols, EMPTY_CHAR) }

    @labyrinth[@exit_row][@exit_col] = EXIT_CHAR
  end

  def have_a_winner
    !@players[@exit_row][@exit_col].nil?
  end

  def to_s
    s = ''
    s += "LABYRINTH (Dimensions: #{@n_rows} X #{@n_cols})\n"
    @n_rows.times do |i|
      @n_cols.times { s += '--' }
      s += "\n|"
      @n_cols.times do |j|
        s += "#{@labyrinth[i][j]}|"
      end
      s += "\n"
    end
    s
  end

  def add_monster(row, col, monster)
    return unless pos_ok(row, col)

    @labyrinth[row][col] = MONSTER_CHAR
    monster.set_pos(row, col)
    @monsters[row][col] = monster
  end

  def spread_players(players)
  end

  def put_player(direction, player)
  end

  def add_block(orientation, start_row, start_col, length)
  end

  def valid_moves(row, col)
  end

  private

  def pos_ok(row, col)
    row < @n_rows && col < @n_cols && row >= 0 && col >= 0
  end

  def empty_pos(row, col)
    @labyrinth[row][col] == EMPTY_CHAR
  end

  def monster_pos(row, col)
    @labyrinth[row][col] == MONSTER_CHAR
  end

  def exit_pos(row, col)
    row == exit_row && col == exit_col
  end

  def combat_pos(row, col)
    @labyrinth[row][col] == COMBAT_CHAR
  end

  def can_step_on(row, col)
    pos_ok(row, col) && (empty_pos(row, col) || monster_pos(row, col))
  end

  def update_old_pos(row, col)
    return unless pos_ok(row, col)

    @labyrinth[row][col] = if combat_pos(row, col)
                             MONSTER_CHAR
                           else
                             EMPTY_CHAR
                           end
  end

  def dir2_pos(row, col, direction)
    return [row, col] if direction.nil?

    case direction
    when Directions::DOWN
      row -= 1
    when Directions::LEFT
      col -= 1
    when Directions::RIGHT
      col += 1
    when Directions::UP
      row += 1
    end
    [row, col]
  end

  def random_empty_pos
    dado = Dice.new

    loop do
      if dado.respond_to?(:random_pos)
        row = dado.random_pos(@n_rows)
        col = dado.random_pos(@n_cols)
      else
        row = dado.randomPos(@n_rows)
        col = dado.randomPos(@n_cols)
      end
      break if empty_pos(row, col)
    end

    [row, col]
  end

  def put_player_2d
  end
end
