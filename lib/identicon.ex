defmodule Identicon do
  @moduledoc """
  Module for converting a given string to an Identicon.
  """

  @doc """
  """
  def main(input) do
		input # "pipe" input into the hash_input method
		|> hash_input # will automatically pass the rusulting struct onto pick_color
		|> pick_color
		|> create_grid
	end

	@doc """
		Hash a given string into a unique series of characters.

		## Examples
			iex> Identicon.hash_input("apple")
			%Identicon.Image{
				hex: [31, 56, 112, 190, 39, 79, 108, 73, 179, 227, 26, 12, 103, 40, 149, 127]
			}

  """
	def hash_input(input) do
		hex = :crypto.hash(:md5, input)
		|> :binary.bin_to_list

		%Identicon.Image{hex: hex}
	end
	
	@doc """
	Get rgb values from a given `Identicon.Image` struct based on its `hex` property value.
	"""
	# pattern matching can be done at the argument level of a function
	# matching done here with Identicon.Image struct, first 3 values then pulled from the hex property of the image argument
	# NOTE: original image argument can still be referenced within the body of the function (and is done so below)
	def pick_color(%Identicon.Image{hex: [r, g, b | _tail]} = image) do # hex property from image gets pattern matched to [r, g, b | _tail]
		# above step done more verbosely:
		# %Identicon.Image{hex: hex_list} = image
		# [r, g, b | _tail] = hex_list

 		# using a tuple for {r, g, b} because each value has a specific meaning
		%{image | color: {r, g, b}} # equivalent to Map.put(image, :color, {r, g, b})
	end
	
	# initial stab at what the tutorial solves with the alternate functions further below
	# def create_grid(%Identicon.Image{hex: hex_list} = image) do
	#		grid = for row <- Enum.chunk_every(hex_list, 3, 3, :discard) do
	#			[a, b | _tail ] = row
	#			row ++ [b, a]
	#		end
	#		%{image | grid: grid}
	# end

	@doc """
	Generate a new `Identicon.Image` struct complete with grid values based on the given images `hex` value.
	"""
	def create_grid(%Identicon.Image{hex: hex_list} = image) do
		# conventional formatting for assigning a variable while using the pipe operator
		grid =
			hex_list
			|> Enum.chunk_every(3, 3, :discard) # hex_list automatically inserted as the first argument of chunk_every# passing a function reference in Elixir requires the use of an ampersand, the name of the function
			# chunked list automatically passed to Enum.map as the first argument
			# passing a function reference in Elixir requires the use of an ampersand and the name of the function followed by /number_of_arguments
			# the function is run for each element of the given collection (chunked list in this case), and a new list is generated
			|> Enum.map(&mirror_row/1)
			# thinking ahead, we want a data structure that will be suitable for generating the Identicon image
			# this way we won't have to do any kind of nested iteration, just a single iteration
			# list generated from Enum.map above is automatically piped into List.flatten
			|> List.flatten # take a nest list (list of lists) and "flatten" it into a single list
			# we're going to need to know what index each element is at in our list in order to generate the image
			# helper method with_index takes a list of elements and generates a new list of tuples of the form [{val0, 0}, {val1, 1}, {val2, 2}, ...] with the second value in the tuple indicating the index
			|> Enum.with_index
		
		%{image | grid: grid}
	end

	@doc """
	Takes a list `row` and generates a new, mirrored list.

		## Examples
			iex> row = [114, 179, 2]
			iex> Identicon.mirror_row(row)
			[114, 179, 2, 179, 114]
	"""
	def mirror_row([a, b | _tail] = row) do
		row ++ [b, a]
	end

end
