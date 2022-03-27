defmodule GlideSlope.AccountsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `GlideSlope.Accounts` context.
  """

  def unique_user_email, do: "user#{System.unique_integer()}@example.com"
  def valid_user_password, do: "hello world!"

  def valid_user_attributes(attrs \\ %{}) do
    Enum.into(attrs, %{
      email: unique_user_email(),
      password: valid_user_password()
    })
  end

  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> valid_user_attributes()
      |> GlideSlope.Accounts.register_user()

    user
  end

  def extract_user_token(fun) do
    {:ok, captured_email} = fun.(&"[TOKEN]#{&1}[TOKEN]")
    [_, token | _] = String.split(captured_email.text_body, "[TOKEN]")
    token
  end

  @doc """
  Generate a transaction.
  """
  def transaction_fixture(attrs \\ %{}) do
    {:ok, transaction} =
      attrs
      |> Enum.into(%{
        amount: "120.5",
        currency: "some currency",
        import_date: ~U[2022-02-04 19:00:00Z],
        text: "some text",
        transaction_date: ~U[2022-02-04 19:00:00Z]
      })
      |> GlideSlope.Transactions.create_transaction()

    transaction
  end
end
