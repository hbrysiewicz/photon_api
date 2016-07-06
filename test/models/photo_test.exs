defmodule PhotoFeedApi.PhotoTest do
  use ExUnit.Case

  alias PhotoFeedApi.{Photo, S3}

  @xml "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<ListBucketResult xmlns=\"http://s3.amazonaws.com/doc/2006-03-01/\"><Name>photo-feed</Name><Prefix></Prefix><Marker></Marker><MaxKeys>1000</MaxKeys><IsTruncated>false</IsTruncated><Contents><Key>arf.png</Key><LastModified>2016-07-05T18:34:03.000Z</LastModified><ETag>&quot;842c37a989afc2db207b05fff8f99cf4&quot;</ETag><Size>178303</Size><Owner><ID>7a0ebca519168154d6c758d6932a31cd3e6089827eb90c662e06deab28516ecf</ID><DisplayName>accounts</DisplayName></Owner><StorageClass>STANDARD</StorageClass></Contents><Contents><Key>meow.png</Key><LastModified>2016-07-05T18:50:39.000Z</LastModified><ETag>&quot;3e25960a79dbc69b674cd4ec67a72c62&quot;</ETag><Size>11</Size><Owner><ID>7a0ebca519168154d6c758d6932a31cd3e6089827eb90c662e06deab28516ecf</ID><DisplayName>accounts</DisplayName></Owner><StorageClass>STANDARD</StorageClass></Contents></ListBucketResult>"

  def xml, do: @xml

  defmodule MockS3 do
    def get_data("photo-feed") do
      S3.parse_data(PhotoFeedApi.PhotoTest.xml())
    end
  end

  # test "list names in bucket" do
  #   expected = [
  #     "arf.png",
  #     "meow.png"
  #   ]

  #   assert Photo.get_data() == expected
  # end

  test "list urls of objects" do
    expected = [
      %{url: "http://s3.amazonaws.com/photo-feed/arf.png",
        last_modified: "2016-07-05T18:34:03.000Z"},
      %{url: "http://s3.amazonaws.com/photo-feed/meow.png",
        last_modified: "2016-07-05T18:50:39.000Z"}
    ]

    assert Photo.get_data("photo-feed") == expected
  end

  test "put object into bucket" do

  end
end