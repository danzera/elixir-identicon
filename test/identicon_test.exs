defmodule IdenticonTest do
  use ExUnit.Case
  doctest Identicon

	test "hash banana...into a hex list and create an Identicon.Image struct with it as a property" do
		input = "banana"
		hashed_input = [114, 179, 2, 191, 41, 122, 34, 138, 117, 115, 1, 35, 239, 239, 124, 65]
		assert Identicon.hash_input(input) == %Identicon.Image{hex: hashed_input}
	end
	
	test "squish banana...into rgb value and add property to Identicon.Image struct" do
		input = "banana"
		hashed_input = [114, 179, 2, 191, 41, 122, 34, 138, 117, 115, 1, 35, 239, 239, 124, 65]
		[r, g, b | _tail] = hashed_input
		image_banana = Identicon.hash_input(input)
		assert Identicon.pick_color(image_banana) == %Identicon.Image{hex: hashed_input, color: {r, g, b}}
	end
end
