defprotocol HalIO do

  @doc """
  Read data from a given IO hardware
  """
  @spec read(struct, non_neg_integer) :: {:ok, bitstring} | {:error, term}
  def read(device, read_count)

  @doc """
  Write data via a given IO hardware
  """
  @spec write(struct, bitstring) :: :ok | {:error, term}
  def write(device, value)

  @doc """
  Transfer data via a given IO hardware. The data read is equivalent to the data written.

  Note: for I2C usage, use read/write separately for custom read counts.
  """
  @spec xfer(struct, bitstring) :: {:ok, bitstring} | {:error, term}
  def xfer(device, value)
end

