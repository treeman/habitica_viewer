defmodule Habitica do
  use HTTPotion.Base

  def process_url(url) do
    "https://habitica.com/api/v3/" <> url
  end

  def process_request_headers(headers) do
    res = Dict.merge(headers, %{
      "x-api-user": Application.get_env(:habitica_viewer, :user_id),
      "x-api-key": Application.get_env(:habitica_viewer, :api_token)
    })
    IO.inspect(res)
    res
  end

  def process_response_body(body) do
      IO.inspect(body)
  end
end

