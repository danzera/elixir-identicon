defmodule IdenticonTest do
  use ExUnit.Case
  doctest Identicon

	test "hash banana" do
		input = "banana"
		hashed_input = [114, 179, 2, 191, 41, 122, 34, 138, 117, 115, 1, 35, 239, 239, 124, 65]
		assert Identicon.hash_input(input) == %Identicon.Image{hex: hashed_input}
	end
	
	test "squish banana...into rgb value (first three of its hex value)" do
		input = "banana"
		hashed_input = [114, 179, 2, 191, 41, 122, 34, 138, 117, 115, 1, 35, 239, 239, 124, 65]
		[a, b, c | _tail] = hashed_input
		image_banana = Identicon.hash_input(input)
		assert Identicon.pick_color(image_banana) == [a, b, c]
	end
end
