defmodule Halio.MockTest do
  use ExUnit.Case
  # doctest Halio

  test "gpio mock test" do

    {:ok, gpio_pid} = HalIO.Device.GPIO.start_link("P9_11", pin_direction: :out)
    gpio_dev = gpio_pid |> HalIO.Device.GPIO.hal()

    HalIO.write(gpio_dev, <<1>>)

  end
end
