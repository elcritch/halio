defmodule HalIO.Mock.SPI do
  require Logger

  @behaviour HalIO.Device.SPI

  @impl true
  def hal(pid, opts) do
    log_level = Keyword.get(opts, :log_level, :nil)

    halio = %HalIO.Mock.GenericProxy{module: __MODULE__, pid: pid}

    halio =
      if log_level do
        %HalIO.LoggerWrapper{parent: halio, level: log_level}
      else
        halio
      end

    halio
  end

  @impl true
  def start_link(spi_port, spi_options, _opts) do
    data =
      Map.new([state: 0])
      |> Map.merge(Map.new(spi_options))

    Agent.start_link(fn -> data end,
      name: "#{__MODULE__}.#{spi_port}" |> String.to_atom() )
  end

  def read(device, read_count) do
    result = Agent.get(device, fn data -> data[:state] end)

    rem = String.slice(result, 0..read_count-1)
    {:ok, rem }
  end

  def write(device, value) do
    :ok = Agent.update(device, fn data -> %{ data | state: value } end)
  end

  def xfer(device, value) do
    result = Agent.get_and_update(device, fn data ->
      {data.state, %{ data | state: value} }
    end)

    rem = String.slice(result, 0..byte_size(value)-1)
    {:ok, rem}
  end
end
