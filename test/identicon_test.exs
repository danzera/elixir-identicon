defmodule IdenticonTest do
  use ExUnit.Case
  doctest Identicon

	test "hash_input test: convert 'banana' into a hex list and create an Identicon.Image struct with it as a property" do
		input = "banana"
		hashed_input = [114, 179, 2, 191, 41, 122, 34, 138, 117, 115, 1, 35, 239, 239, 124, 65]
		
		assert Identicon.hash_input(input) == %Identicon.Image{hex: hashed_input}
	end
	
	test "pick_color test: convert 'banana' into an rgb value and add property to Identicon.Image struct" do
		input = "banana"
		hashed_input = [114, 179, 2, 191, 41, 122, 34, 138, 117, 115, 1, 35, 239, 239, 124, 65]
		
		[r, g, b | _tail] = hashed_input
		image_banana = Identicon.hash_input(input)
		assert Identicon.pick_color(image_banana) == %Identicon.Image{hex: hashed_input, color: {r, g, b}}
	end

	test "create_grid test: convert 'pizza' into grid values for Identicon.Image struct" do
		input = "pizza"
		expected_grid = [{124,0},{242,1},{219,2},{242,3},{124,4},{94,5},{194,6},{97,7},{194,8},{94,9},{160,10},{250,11},{39,12},{250,13},{160,14},{165,15},{2,16},{211,17},{2,18},{165,19},{25,20},{106,21},{111,22},{106,23},{25,24}]

		image = Identicon.create_grid(Identicon.hash_input(input))
		assert image.grid == expected_grid
	end

	test "filter_grid test: convert 'pizza' grid values to only its even values" do
		_input = "pizza"
		grid = [{124,0},{242,1},{219,2},{242,3},{124,4},{94,5},{194,6},{97,7},{194,8},{94,9},{160,10},{250,11},{39,12},{250,13},{160,14},{165,15},{2,16},{211,17},{2,18},{165,19},{25,20},{106,21},{111,22},{106,23},{25,24}]
		filtered_grid = [{124,0},{242,1},{242,3},{124,4},{94,5},{194,6},{194,8},{94,9},{160,10},{250,11},{250,13},{160,14},{2,16},{2,18},{106,21},{106,23}]
		image =
			%Identicon.Image{grid: grid}
			|> Identicon.filter_grid

		assert filtered_grid == image.grid
	end

	test "build_pixel_map test: convert 'pizza' into a pixel map and add to Identicon.Image struct" do
		input = "pizza"
		filtered_grid = [{124,0},{242,1},{242,3},{124,4},{94,5},{194,6},{194,8},{94,9},{160,10},{250,11},{250,13},{160,14},{2,16},{2,18},{106,21},{106,23}]
		image = %Identicon.Image{grid: filtered_grid}
		expected_pixel_map =
			[{{0, 0},{50, 50}}, {{50, 0},{100, 50}}, {{150, 0},{200, 50}}, {{200, 0},{250, 50}},
				{{0, 50},{50, 100}}, {{50, 50},{100, 100}}, {{150, 50},{200, 100}}, {{200, 50},{250, 100}},
				{{0, 100},{50, 150}}, {{50, 100},{100, 150}}, {{150, 100},{200, 150}}, {{200, 100},{250, 150}},
				{{50, 150},{100, 200}}, {{150, 150},{200, 200}},
				{{50, 200},{100, 250}}, {{150, 200},{200, 250}}]

		assert expected_pixel_map == Identicon.build_pixel_map(image).pixel_map
	end

end
