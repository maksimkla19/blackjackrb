module Interface
  CHOICES_MENU = {
    '1' => { label: 'Взять карту', action: :take },
    '2' => { label: 'Открыть карты', action: :open },
    '3' => { label: 'Пропустить ход', action: :skip }
  }.freeze
  GAME_MENU = {
    '1' => { label: 'Продолжить игру', action: :continue },
    '0' => { label: 'Взять банк и покинуть казино', action: :exit }
  }.freeze

  module_function

  def name
    ask('=> Как вас зовут?').capitalize
  end

  def menu(menu)
    showmenu(menu)
    while choice = menu[ask('?>').to_s] || {}

      break choice[:action] unless choice[:action].nil?

      unknown_command
    end
  end

  def show_round_welcome(number)
    puts '==================='
    puts "===== Раунд #{number} ====="
  end

  def show_winner(name)
    puts '==================='
    puts "=> Раунд выиграл #{name}"
  end

  def show_draw
    puts '==================='
    puts '=> Ничья, ставки возвращены'
  end

  def show_status(name, bank)
    puts "Игрок #{name} ($#{bank})"
  end

  def show_decision(name, decision)
    decision ||= :none
    puts "Ход #{name}, решение: #{decision}"
  end

  def show_cards(name, cards, score)
    puts "Карты #{name}: #{cards} [#{score}]"
  end

  def welcome_message
    puts '--- Добро пожаловать ---'
    puts '--- в игру Blackjack ---'
  end

  def show_ruined(player_name)
    puts '--- Игра окончена ---'
    puts "=> Игрок #{player_name} весь проигрался"
  end

  def show_final(name, money)
    if money < 0
      puts "=> Всего доброго, #{name}! Ваш проигрыш составил $#{money.abs}"
    else
      puts "=> Всего доброго, #{name}! Ваш выигрыш составил $#{money}"
    end
  end

  def ask(question)
    print question + ' '
    gets.chomp
  end

  def unknown_command
    puts '=> unknown command'
  end

  def showmenu(menu)
    puts '-------------------'
    menu.each { |k, v| puts "#{k} - #{v[:label]}" }
    puts '-------------------'
  end
end
