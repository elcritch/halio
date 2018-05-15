defprotocol HalIO do

  @doc "Read data via a given IO hardware"
  @spec read(struct, non_neg_integer) :: binary | {:error, term}
  def read(device, read_count)

  @doc """
  Transfer data via a given IO hardware. The data read is equivalent to the data written.

  Note: for I2C usage, use read/write separately for custom read counts.
  """
  @spec xfer(struct, binary) :: binary | {:error, term}
  def xfer(device, value)

  @doc "Write data via a given IO hardware"
  @spec write(struct, binary) :: :ok | {:error, term}
  def write(device, value)

end

