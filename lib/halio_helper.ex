defmodule HalIO.Helper do

  def chunk_bits(binary, n) do
    for << chunk::size(n) <- binary >>, do: <<chunk::size(n)>>
  end

end

