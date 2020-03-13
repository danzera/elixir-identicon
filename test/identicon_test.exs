defmodule IdenticonTest do
  use ExUnit.Case
  doctest Identicon

	test "hash banana" do
		input = "banana"
		hashed_input = [114, 179, 2, 191, 41, 122, 34, 138, 117, 115, 1, 35, 239, 239, 124, 65]
		assert Identicon.hash_input(input) == hashed_input
  end
end
