defmodule HalIO.Mock.I2C do
  require Logger

  @behaviour HalIO.Device.I2C

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
  def start_link(gpio_port, gpio_options, _opts) do
    data =
      Map.new([state: 0])
      |> Map.merge(Map.new(gpio_options))

    Agent.start_link(fn -> data end,
      name: "#{__MODULE__}.#{gpio_port}" |> String.to_atom() )
  end

  def read(device, _read_count) do
    {:ok, Agent.get(device, fn data -> data[:state] end)}
  end

  def write(device, value) do
    :ok = Agent.update(device, fn data -> %{ data | state: value } end)
  end

  def xfer(device, value) do
    result = Agent.get_and_update(device, fn data ->
      {data.state, %{ data | state: value} }
    end)

    {:ok, result}
  end
end
