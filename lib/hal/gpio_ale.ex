
defmodule PaleAle.HalIO.GPIO.Ale do
  @enforce_keys [:pid, :pin]
  defstruct @enforce_keys
end

defimpl PaleAle.HalIO, for: PaleAle.HalIO.GPIO.Ale do
  alias ElixirALE.GPIO

  def read(device) do
    GPIO.read(device.pid)
  end
  def write(device, value) do
    GPIO.write(device.pid, value)
  end
  def xfer(device, value) do
    res = GPIO.read(device.pid)
    GPIO.write(device.pid, value)
    res
  end
end


