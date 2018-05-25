defmodule HalIO.Mock.SPI do
  require Logger

  @behaviour HalIO.Device.SPI

  @impl true
  def hal(pid, opts) do
    log_level = Keyword.get(opts, :log_level)
    %HalIO.LoggerWrapper{parent: pid, level: log_level}
  end

  @impl true
  def start_link(gpio_port, gpio_options, _opts) do
    Agent.start_link(fn -> Map.new(gpio_options) end,
      name: "#{__MODULE__}.#{gpio_port}" |> String.to_atom() )
  end

  def read(device, _read_count) do
    Agent.get(device, fn data -> data[:state] end)
  end

  def write(device, value) do
    :ok = Agent.update(device, fn data -> %{ data | state: value } end)
  end

  def xfer(device, value) do
    Agent.get_and_update(device, fn data ->
      {data.state, %{ data | state: value} }
    end)
  end

end
