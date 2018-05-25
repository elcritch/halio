
defmodule HalIO.Devices do

end

defmodule HalIO.Device.GPIO do

  @gpio Application.get_env(:halio, :gpio_module)

  @callback start_link(binary, [term], [term]) :: {:ok, pid}

  def start_link(binary, gpio_opts, opts) do
    @gpio.start_link(binary, gpio_opts, opts)
  end

end

defmodule HalIO.Device.SPI do

  @spi Application.get_env(:halio, :spi_module)

  @callback start_link(binary, [term], [term]) :: {:ok, pid}

  def start_link(binary, spi_opts, opts) do
    @spi.start_link(binary, spi_opts, opts)
  end

end


defmodule HalIO.Device.I2C do

  @i2c Application.get_env(:halio, :i2c_module)

  @callback start_link(binary, [term], [term]) :: {:ok, pid}

  def start_link(binary, i2c_opts, opts) do
    @i2c.start_link(binary, i2c_opts, opts)
  end

end
