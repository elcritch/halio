defmodule PaleAle.HalIO.I2C.Ale do
  @enforce_keys [:pid, :bus_name]
  defstruct @enforce_keys ++ [:address]
end

defimpl PaleAle.HalIO, for: PaleAle.HalIO.I2C.Ale do
  alias ElixirALE.I2C

  def read(%{address: nil} = device), do: I2C.read(device.pid)
  def read(%{address: addr} = device), do: I2C.read_device(device.pid, addr)

  def write(%{address: nil} = device, val), do: I2C.write(device.pid, val)
  def write(%{address: addr} = device, val), do: I2C.write_device(device.pid, addr, val)

  def xfer(%{address: nil} = device, value) do
    I2C.write_read(device.pid, value)
  end

  def xfer(%{address: addr} = device, value) do
    I2C.write_read_device(device.pid, addr, value)
  end
end

