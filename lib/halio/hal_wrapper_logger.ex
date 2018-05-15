
defmodule HalIO.LoggerWrapper do
  @enforce_keys [:parent, :level]
  defstruct [:name, :parent, :level, :options]
end

defimpl HalIO, for: HalIO.LoggerWrapper  do
  require Logger

  def read(device, read_count) do
    result = HalIO.read(device.parent, read_count)
    Logger.log(device.level, "#{__MODULE__}:read(#{inspect device}, #{inspect read_count}) :: #{inspect result} ")

    result
  end

  def write(device, value) do
    result = HalIO.write(device.parent, value)
    Logger.log(device.level, "#{__MODULE__}:write(#{inspect device}, #{inspect value}) :: #{inspect result} ")

    result
  end

  def xfer(device, value) do
    result = HalIO.xfer(device.parent, value)
    Logger.log(device.level, "#{__MODULE__}:xfer(#{inspect device}, #{inspect value}) :: #{inspect result} ")

    result
  end
end

