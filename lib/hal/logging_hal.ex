
defmodule PaleAle.HalIO.Test do
  defstruct [:name, :count]
end

defimpl PaleAle.HalIO, for: PaleAle.HalIO.Test do
  def read(device) do
    IO.puts("PaleAle.HalIO read: #{inspect device} ")
  end
  def write(device, value) do
    IO.puts("PaleAle.HalIO write: #{inspect device} value: #{inspect value}")
  end
  def xfer(device, value) do
    IO.puts("PaleAle.HalIO xfer: #{inspect device} value: #{inspect value}")
  end
end
