defmodule PhotoFeedApi.Photo do
  @s3_client Application.get_env(:photo_feed_api, :s3_client)
  @bucket_name "photo-feed"

  def get_data() do
    @s3_client.get_data(@bucket_name)
  end

  def upload(payload) do
    data =
      payload["body"]["data"]
      |> String.replace("data:image/png;base64,", "")
      |> Base.decode64!()

    file_name = payload["body"]["filename"]

    {:ok, result} = @s3_client.put_object(@bucket_name, file_name, data)

    headers =
      result.headers
      |> Enum.into(%{}, fn(h) -> h end)

    %{url: photo_url(file_name),
      last_modified: headers["Date"]}
  end

  def photo_url(file_name) do
     "http://s3.amazonaws.com/#{@bucket_name}/#{file_name}"
  end
end