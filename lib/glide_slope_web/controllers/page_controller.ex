defmodule GlideSlopeWeb.PageController do
  use GlideSlopeWeb, :controller

  alias GlideSlope.Accounts
  alias GlideSlope.Accounts.User

  def index(conn, _params) do
    changeset = Accounts.change_user_registration(%User{})
    render(conn, "index.html", changeset: changeset, error_message: nil);
  end
end
