defmodule GlideSlopeWeb.TransactionControllerTest do
  use GlideSlopeWeb.ConnCase

  import GlideSlope.AccountsFixtures

  alias GlideSlope.Accounts.Transaction

  @create_attrs %{
    amount: "120.5",
    currency: "some currency",
    import_date: ~U[2022-02-04 19:00:00Z],
    text: "some text",
    transaction_date: ~U[2022-02-04 19:00:00Z]
  }
  @update_attrs %{
    amount: "456.7",
    currency: "some updated currency",
    import_date: ~U[2022-02-05 19:00:00Z],
    text: "some updated text",
    transaction_date: ~U[2022-02-05 19:00:00Z]
  }
  @invalid_attrs %{amount: nil, currency: nil, import_date: nil, text: nil, transaction_date: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all transactions", %{conn: conn} do
      conn = get(conn, Routes.transaction_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create transaction" do
    test "renders transaction when data is valid", %{conn: conn} do
      conn = post(conn, Routes.transaction_path(conn, :create), transaction: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.transaction_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "amount" => "120.5",
               "currency" => "some currency",
               "import_date" => "2022-02-04T19:00:00Z",
               "text" => "some text",
               "transaction_date" => "2022-02-04T19:00:00Z"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.transaction_path(conn, :create), transaction: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update transaction" do
    setup [:create_transaction]

    test "renders transaction when data is valid", %{conn: conn, transaction: %Transaction{id: id} = transaction} do
      conn = put(conn, Routes.transaction_path(conn, :update, transaction), transaction: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.transaction_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "amount" => "456.7",
               "currency" => "some updated currency",
               "import_date" => "2022-02-05T19:00:00Z",
               "text" => "some updated text",
               "transaction_date" => "2022-02-05T19:00:00Z"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, transaction: transaction} do
      conn = put(conn, Routes.transaction_path(conn, :update, transaction), transaction: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete transaction" do
    setup [:create_transaction]

    test "deletes chosen transaction", %{conn: conn, transaction: transaction} do
      conn = delete(conn, Routes.transaction_path(conn, :delete, transaction))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.transaction_path(conn, :show, transaction))
      end
    end
  end

  defp create_transaction(_) do
    transaction = transaction_fixture()
    %{transaction: transaction}
  end
end
