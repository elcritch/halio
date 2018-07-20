defmodule HalIO.ByteInterface do

  @callback start_link(binary, [term], [term]) :: {:ok, pid}

  @doc """
  Read data from IO bus / hardware
  """
  @callback read(self :: pid(), count :: non_neg_integer() ) :: {:ok, binary} | {:error, term}

  @doc """
  Write data from IO bus / hardware
  """
  @callback write(self :: pid(), data :: binary() ) :: :ok | {:error, term}

  @doc """
  Transfer data via a given IO bus.

  Note: for I2C usage, use read/write separately for custom read counts.
  """
  @callback xfer(self :: pid(), data :: binary() ) :: {:ok, binary} | {:error, term}

  @optional_callbacks start_link: 3

  @doc "default implementations"
  defmacro __using__(_opts) do
    quote do
      @behaviour HalIO.ByteInterface

      @impl true
      def read(device, count), do: GenServer.call(device, {:read, count})

      @impl true
      def write(device, data), do: GenServer.call(device, {:write, data})

      @impl true
      def xfer(device, data), do: GenServer.call(device, {:xfer, data})
    end
  end
end
