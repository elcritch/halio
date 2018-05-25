defmodule HalIO.Mock.GPIO do
  require Logger

  @behaviour HalIO.Device.GPIO

  @impl true
  def start_link(gpio_port, gpio_options, _opts \\ []) do
    Agent.start_link(fn -> Map.new(gpio_options) end,
                      name: "#{__MODULE__}.#{gpio_port}")
  end

  def read(device, read_count) do

    result = Agent.get(device, fn data -> data[:state] end)

    Logger.log(device.level, "#{__MODULE__}:read(#{inspect device}, #{inspect read_count}) :: #{inspect result} ")

    result
  end

  def write(device, value) do
    result = Agent.update(device, fn data -> %{ data | state: value } end)
    :ok = result

    Logger.log(device.level, "#{__MODULE__}:write(#{inspect device}, #{inspect value}) :: #{inspect result} ")

    result
  end

  def xfer(device, value) do
    result = Agent.get_and_update(device, fn data ->
      {data.state, %{ data | state: value} }
    end)

    Logger.log(device.level, "#{__MODULE__}:xfer(#{inspect device}, #{inspect value}) :: #{inspect result} ")

    result
  end

end
