
defmodule PaleAle.HalIO.SPI.Ale.ManualSelect do
  @enforce_keys [:pid, :select_pin]
  defstruct @enforce_keys
end

defimpl PaleAle.HalIO, for: PaleAle.HalIO.SPI.Ale.ManualSelect do
  alias ElixirALE.SPI
  alias ElixirALE.GPIO

  def read(%{select_pin: select_pin} = device) do
    GPIO.write(select_pin, 0)
    res = SPI.transfer(device.pid, << 0x0 >>)
    GPIO.write(select_pin, 1)
    res
  end

  def write(%{select_pin: select_pin} = device, value) do
    GPIO.write(select_pin, 0)
    SPI.transfer(device.pid, value)
    GPIO.write(select_pin, 1)

    :ok
  end

  def xfer(%{select_pin: select_pin} = device, value) do
    GPIO.write(select_pin, 0)
    res = SPI.transfer(device.pid, device)
    GPIO.write(select_pin, 1)

    res
  end
end

