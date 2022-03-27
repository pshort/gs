defmodule GlideSlopeWeb.TransactionView do
  use GlideSlopeWeb, :view
  alias GlideSlopeWeb.TransactionView

  def render("index.json", %{transactions: transactions}) do
    %{data: render_many(transactions, TransactionView, "transaction.json")}
  end

  def render("show.json", %{transaction: transaction}) do
    %{data: render_one(transaction, TransactionView, "transaction.json")}
  end

  def render("transaction.json", %{transaction: transaction}) do
    %{
      id: transaction.id,
      amount: transaction.amount,
      currency: transaction.currency,
      text: transaction.text,
      transaction_date: transaction.transaction_date,
      import_date: transaction.import_date
    }
  end
end
