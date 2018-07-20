
defmodule HalIO.TestLogger do
  require Logger
  use GenServer
  use HalIO.ByteInterface

  @enforce_keys [:default_value]
  defstruct [:name, :default_value, :options]

  @impl true
  def start_link(devname, spi_opts \\ [], opts \\ []) do
    GenServer.start_link(__MODULE__, {devname, spi_opts}, opts)
  end

  @impl GenServer
  def init(args) do
    {:ok, args}
  end

  @impl true
  def handle_call({:read, count}, _from, state) do
    Logger.debug("#{__MODULE__}:read(#{inspect count}):: #{inspect state} ")
    {:reply, state.default_value, state}
  end

  @impl true
  def handle_call({:write, data}, _from, state) do
    Logger.debug("#{__MODULE__}:write:: #{inspect state} value: #{inspect data}")
    {:reply, :ok, state}
  end

  @impl true
  def handle_call({:xfer, data}, _from, state) do
    Logger.debug("#{__MODULE__}:xfer:: #{inspect state} value: #{inspect data}")

    {:reply, state.default_value, state}
  end
end

