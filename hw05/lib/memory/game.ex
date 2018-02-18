
defmodule Memory.Game do
  def new do
    %{tiles: make_tiles(),
      visible: [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
      clicks: 0,
      active: 0,
      matches: 0,
      score: 20,
      second: -1,
      first: -1
    }
  end

  def client_view(game) do
    ws = String.graphemes(game.word)
    gs = game.guesses
    %{
      skel: skeleton(ws, gs),
      goods: Enum.filter(gs, &(Enum.member?(ws, &1))),
      bads: Enum.filter(gs, &(!Enum.member?(ws, &1))),
      max: max_guesses(),
    }
  end

  def skeleton(word, guesses) do
    Enum.map word, fn cc ->
      if Enum.member?(guesses, cc) do
        cc
      else
        "_"
      end
    end
  end

  def guess(game, letter) do
    if letter == "z" do
      raise "That's not a real letter"
    end

    gs = game.guesses
    |> MapSet.new()
    |> MapSet.put(letter)
    |> MapSet.to_list

    Map.put(game, :guesses, gs)
  end

  def max_guesses do
    10
  end

  def make_tiles do
    tiles = ~w(A B C D E F G H A B C D E F G H)
    Enum.shuffle(tiles)
  end
end
