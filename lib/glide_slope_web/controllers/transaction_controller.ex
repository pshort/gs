defmodule GlideSlopeWeb.TransactionController do
  use GlideSlopeWeb, :controller

  alias GlideSlope.Transactions
  alias GlideSlope.Transactions.Transaction

  action_fallback GlideSlopeWeb.FallbackController

  def index(conn, _params) do
    user = conn.assigns[:current_user]
    IO.inspect(user)
    transactions = Transactions.list_transactions(user.id)
    render(conn, "index.json", transactions: transactions)
  end

  def create(conn, %{"transaction" => transaction_params}) do
    with {:ok, %Transaction{} = transaction} <- Transactions.create_transaction(transaction_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.transaction_path(conn, :show, transaction))
      |> render("show.json", transaction: transaction)
    end
  end

  def show(conn, %{"id" => id}) do
    transaction = Transactions.get_transaction!(id)
    render(conn, "show.json", transaction: transaction)
  end

  def update(conn, %{"id" => id, "transaction" => transaction_params}) do
    transaction = Transactions.get_transaction!(id)

    with {:ok, %Transaction{} = transaction} <- Transactions.update_transaction(transaction, transaction_params) do
      render(conn, "show.json", transaction: transaction)
    end
  end

  def delete(conn, %{"id" => id}) do
    transaction = Transactions.get_transaction!(id)

    with {:ok, %Transaction{}} <- Transactions.delete_transaction(transaction) do
      send_resp(conn, :no_content, "")
    end
  end
end
