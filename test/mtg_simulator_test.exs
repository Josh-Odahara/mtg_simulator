defmodule MtgSimulatorTest do
  use ExUnit.Case
  doctest MtgSimulator

  test "greets the world" do
    assert MtgSimulator.hello() == :world
  end
end
