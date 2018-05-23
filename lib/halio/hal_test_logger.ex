
defmodule HalIO.TestLogger do
  @enforce_keys [:default_value]
  defstruct [:name, :default_value, :options]
end

defimpl HalIO, for: HalIO.TestLogger do
  require Logger

  def read(device, _read_count) do
    Logger.debug("#{__MODULE__}:read:: #{inspect device} ")

    {:ok, device.default_value}
  end

  def write(device, value) do
    Logger.debug("#{__MODULE__}:write:: #{inspect device} value: #{inspect value}")
    :ok
  end

  def xfer(device, value) do
    Logger.debug("#{__MODULE__}:xfer:: #{inspect device} value: #{inspect value}")

    {:ok, device.default_value}
  end
end

