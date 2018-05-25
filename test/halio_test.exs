defmodule Halio.MockTest do
  use ExUnit.Case
  # doctest Halio

  test "gpio mock test" do
    {:ok, pid} = HalIO.Device.GPIO.start_link("P9_11", pin_direction: :out)
    dev = HalIO.Device.GPIO.hal(pid)

    :ok = HalIO.write(dev, <<1>>)
    {:ok, <<1>>} = HalIO.read(dev, 1)
    {:ok, <<1>>} = HalIO.xfer(dev, <<0>>)
    {:ok, <<0>>} = HalIO.read(dev, 1)
  end

  test "spi mock test" do
    {:ok, pid} = HalIO.Device.SPI.start_link("spi0.0", pin_direction: :out)
    dev = HalIO.Device.SPI.hal(pid)

    :ok = HalIO.write(dev, <<1, 0, 1, 0>>)
    result = HalIO.read(dev, 3)
    {:ok, <<1, 0, 1>>} = result

    {:ok, <<1>>} = HalIO.xfer(dev, <<0>>)

    {:ok, <<0>>} = HalIO.read(dev, 1)
  end

end
