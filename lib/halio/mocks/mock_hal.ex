defmodule HalIO.Mock.GenericProxy do
  defstruct [:pid, :module]

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
  def handle_call({:read, count}, _from, proxy) do
    result = apply(proxy.module, :read, [proxy.pid, count])
    {:reply, result, proxy}
  end

  @impl true
  def handle_call({:write, data}, _from, proxy) do
    result = apply(proxy.module, :write, [proxy.pid, data])
    {:reply, result, proxy}
  end

  @impl true
  def handle_call({:xfer, data}, _from, proxy) do
    result = apply(proxy.module, :xfer, [proxy.pid, data])
    {:reply, result, proxy}
  end

end
