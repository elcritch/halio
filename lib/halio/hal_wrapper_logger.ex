
defmodule HalIO.LoggerWrapper do
  @enforce_keys [:parent, :level]
  defstruct [:name, :parent, :level, :options]

  require Logger
  use HalIO.ByteInterface
  use GenServer

  @impl true
  def start_link(devname, spi_opts \\ [], opts \\ []) do
    GenServer.start_link(__MODULE__, {devname, spi_opts}, opts)
  end

  @impl true
  def init(args) do
    {:ok, args}
  end

  @impl true
  def handle_call({:read, count}, _from, device) do
    result = HalIO.read(device.parent, count)
    Logger.log(device.level, "#{__MODULE__}:read(#{inspect device}, #{inspect count}) :: #{inspect result} ")
    {:reply, result, device}
  end

  @impl true
  def handle_call({:write, data}, _from, device) do
    result = HalIO.write(device.parent, data)
    Logger.log(device.level, "#{__MODULE__}:write(#{inspect device}, #{inspect data}) :: #{inspect result} ")
    {:reply, result, device}
  end

  @impl true
  def handle_call({:xfer, data}, _from, device) do
    result = HalIO.xfer(device.parent, data)
    Logger.log(device.level, "#{__MODULE__}:xfer(#{inspect device}, #{inspect data}) :: #{inspect result} ")

    {:reply, result, device}
  end
end

