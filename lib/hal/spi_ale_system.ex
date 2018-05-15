
defmodule PaleAle.HalIO.SPI.Ale do
  @enforce_keys [:pid]
  defstruct @enforce_keys
end

defimpl PaleAle.HalIO, for: PaleAle.HalIO.SPI.Ale do
  alias ElixirALE.SPI

  def read(device) do
    res = SPI.transfer(device.pid, << 0x0 >>)
    res
  end

  def write(device, value) do
    SPI.transfer(device.pid, value)

    :ok
  end

  def xfer(device, value) do
    res = SPI.transfer(device.pid, value)

    res
  end
end

