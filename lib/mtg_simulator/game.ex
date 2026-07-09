defmodule MTGSimulator.Game do
  @moduledoc """
  Game keeps all the logic behind turns and phases
  """
  alias MTGSimulator.Card
  alias MTGSimulator.Player
  alias MTGSimulator.AttackCard
  alias MTGSimulator.DefenseCard

  def new_deck() do
    Card.start_deck()
  end

  def shuffle_deck(deck) do
    Enum.shuffle(deck)
  end

  def deal_hand(deck) do
    {hand, remaining_deck} = Enum.split(deck, 5)
    {hand, remaining_deck}
  end

  def draw_card(deck) do
    [card | remaining_deck] = deck
    {card, remaining_deck}
  end

  def determine_winner(player1, player2) do
    player1_score = player1.life
    player2_score = player2.life

    cond do
      player1_score <= 0 -> :player2
      player2_score <= 0 -> :player1
      true -> :tie
    end
  end

  def draw_card_for_player(player) do
    {card, remaining_deck} = draw_card(player.deck)

    updated_player = %MTGSimulator.Player{
      player
      | deck: remaining_deck,
        hand: [card | player.hand]
    }

    updated_player
  end

  def discard_card_for_player(player, picked_card) do
    discard_card = Enum.reject(player.hand, fn card -> card.name == picked_card.name end)
    updated_player = %MTGSimulator.Player{player | hand: discard_card}
    updated_player
  end

  def choose_card_for_player(player) do
    Enum.each(player.hand, fn card -> IO.puts(card.name) end)
    find_card = IO.gets("Choose your card: ") |> String.trim()
    Enum.find(player.hand, fn card -> card.name == find_card end)
  end

  def play_attack_card(player1, player2, picked_card) do
    IO.puts(picked_card.name)

    discard_card = Enum.reject(player1.hand, fn card -> card.name == picked_card.name end)
    updated_player1 = %MTGSimulator.Player{player1 | hand: discard_card}
    updated_player2 = %MTGSimulator.Player{player2 | life: player2.life - picked_card.damage}
    {updated_player1, updated_player2}
  end

  def play_defense_card(player1, player2, picked_card, incoming_damage) do
    IO.puts(picked_card.name)

    case picked_card.effect do
      :heal ->
        updated_player1 = %MTGSimulator.Player{player1 | life: 100}
        discarded_player1 = discard_card_for_player(updated_player1, picked_card)
        {discarded_player1, player2}

      :reverse ->
        updated_player2 = %MTGSimulator.Player{player2 | life: player2.life - incoming_damage}
        discarded_player1 = discard_card_for_player(player1, picked_card)
        {discarded_player1, updated_player2}

      :reverse_double ->
        updated_player2 = %MTGSimulator.Player{player2 | life: player2.life - incoming_damage * 2}
        discarded_player1 = discard_card_for_player(player1, picked_card)
        {discarded_player1, updated_player2}

      :bypass ->
        discarded_player1 = discard_card_for_player(player1, picked_card)
        {discarded_player1, player2}

      :block ->
        updated_player1 = %MTGSimulator.Player{
          player1
          | life: player1.life - (incoming_damage - picked_card.block)}
        discarded_player1 = discard_card_for_player(updated_player1, picked_card)
        {discarded_player1, player2}
      end
  end

  def turn_loop(player1, player2) do
    updated_player1 = draw_card_for_player(player1)
    picked_card = choose_card_for_player(updated_player1)

    {p1, p2} = case picked_card do
      %AttackCard{} ->
        updated_player2 = draw_card_for_player(player2)
        chosen_card = choose_card_for_player(updated_player2)

        case chosen_card do
            %AttackCard{} ->
              play_attack_card(updated_player1, updated_player2, chosen_card)
            %DefenseCard{} ->
              play_defense_card(updated_player1, updated_player2, chosen_card, picked_card.damage)
        end

      %DefenseCard{effect: :heal} ->
        play_defense_card(updated_player1, player2, picked_card, 0)
      %DefenseCard{} ->
        {updated_player1, player2}
    end

          case determine_winner(p1, p2) do
        :player1 -> IO.puts("Player 1 wins!")
        :player2 -> IO.puts("Player 2 wins!")
        :tie -> turn_loop(p1, p2)
      end
  end
end
