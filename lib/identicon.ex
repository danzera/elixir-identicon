defmodule Identicon do
  @moduledoc """
  Module for converting a given string to an Identicon.
  """

  @doc """
  """
  def main(input) do
		input # "pipe" input into the hash_input method
		|> hash_input
		# |> function_three
		# |> function_four
	end

	@doc """
		Hash a given string into a unique series of characters.

		## Examples
			iex> Identicon.hash_input("apple")
			[31, 56, 112, 190, 39, 79, 108, 73, 179, 227, 26, 12, 103, 40, 149, 127]

  """
	def hash_input(input) do
		:crypto.hash(:md5, input)
		|> :binary.bin_to_list
	end

end
