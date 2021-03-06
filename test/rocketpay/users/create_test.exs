defmodule Rocketpay.Users.CreateTest do
  use Rocketpay.DataCase, async: true

  alias Rocketpay.User
  alias Rocketpay.Users.Create

  describe "call/1" do
    test "when all parameters are valid, returns an user" do
      params = %{
        name: "Gabriel",
        password: "123456",
        nickname: "Gabrielbzl",
        email: "gabriel@braga.com",
        age: 20
      }

      {:ok, %User{id: user_id}} = Create.call(params)
      user = Repo.get(User, user_id)

      assert %User{name: "Gabriel", age: 20, id: ^user_id} = user
    end
  end

  test "when there are invalid params, returns an error" do
    params = %{
      name: "Gabriel",
      nickname: "Gabrielbzl",
      email: "gabriel@braga.com",
      age: 15
    }

    {:error, changeset} = Create.call(params)

    expected_response = %{
      age: ["must be greater than or equal to 18"],
      password: ["can't be blank"]
    }
    assert errors_on(changeset) == expected_response
  end
end
