defmodule KV.BucketTest do
  use ExUnit.Case, async: true
  # this test runs parallel with other tests with async: true
  # only set async: true, if the test doesn't need any writing operation,
  # like in the filesystem or database, to avoid race conditions

  ### not effective style
  test "stores values by key" do
    # starts the `agent` KV.Bucket
    {:ok, bucket} = KV.Bucket.start_link([])
    assert KV.Bucket.get(bucket, "milk") == nil

    KV.Bucket.put(bucket, "milk", 3)
    assert KV.Bucket.get(bucket, "milk") == 3
  end

  ### with callbacks
  # - setup (this is a macro) will be executed before every test
  # - it generates a new bucket
  setup do
    {:ok, bucket} = KV.Bucket.start_link([])
    %{bucket: bucket}
  end

  # - here we are using the "test context"
  # - ExUnit merges the return from the callback into the "test context"
  test "storey values by key", %{bucket: bucket} do
    assert KV.Bucket.get(bucket, "milk") == nil

    KV.Bucket.put(bucket, "milk", 3)
    assert KV.Bucket.get(bucket, "milk") == 3
  end

  test "deletes values by key", %{bucket: bucket} do
    KV.Bucket.put(bucket, "milk", 3)
    assert KV.Bucket.get(bucket, "milk") == 3

    KV.Bucket.delete(bucket, "milk")
    assert KV.Bucket.get(bucket, "milk") == nil
  end
end
