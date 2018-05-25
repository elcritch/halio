defmodule HalIO.Mock.GenericProxy do
  defstruct [:pid, :module]
end

defimpl HalIO, for: HalIO.Mock.GenericProxy  do
  require Logger

  def read(proxy, read_count) do
    apply(proxy.module, :read, [proxy.pid, read_count])
  end

  def write(proxy, value) do
    apply(proxy.module, :write, [proxy.pid, value])
  end

  def xfer(proxy, value) do
    apply(proxy.module, :xfer, [proxy.pid, value])
  end

end
