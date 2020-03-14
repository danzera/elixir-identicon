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
		# |> function_four
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

end
