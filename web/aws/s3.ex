defmodule PhotoFeedApi.S3 do
  use ExAws.S3.Client, otp_app: :photo_feed_api

  def config_root do
    Application.get_all_env(:ex_aws)
  end

  def get_data(bucket_name) do
    bucket_name
    |> list_objects!()
    |> Map.get(:body)
    |> Quinn.parse()
    |> Quinn.find(:Contents)
    |> Enum.map(fn(node) ->
      %{url: get_url(node, bucket_name), last_modified: get_last_modified(node)}
    end)
  end

  defp get_url(node, bucket_name) do
    PhotoFeedApi.Photo.photo_url(get_key(node, :Key))
  end

  defp get_last_modified(node) do
    get_key(node, :LastModified)
  end

  defp get_key(node, key) do
    [%{value: [value]}] = Quinn.find(node, key)

    value
  end
end