defmodule HelloOtpTest do
  use ExUnit.Case
  doctest HelloOtp

  test "greets the world" do
    assert HelloOtp.hello() == :world
  end
end
