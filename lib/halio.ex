defprotocol HalIO do
  @doc "read data via a given bus"
  def read(device)
  @doc "write data via a given bus"
  def write(device, value)
  @doc "transfer data via a given bus"
  def xfer(device, value)
end
