defmodule HalioTest do
  use ExUnit.Case
  doctest Halio

  test "greets the world" do
    assert Halio.hello() == :world
  end
end
