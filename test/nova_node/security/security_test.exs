defmodule NovaNode.SecurityTest do
  use NovaNode.DataCase

  alias NovaNode.Security
  alias NovaNode.Security.Token

  @token_attrs get_token_attrs()

  test "create_token/1 creates a valid token" do
    assert {:ok, token} = Security.create_token(@token_attrs)
    assert %Token{} = token
    assert token.key == @token_attrs.key
    assert token.secret == @token_attrs.secret
  end

  test "create_random_token/0 creates a valid token" do
    assert {:ok, token} = Security.create_random_token()
    assert %Token{} = token
    assert 32 == String.length(token.key)
    assert 64 == String.length(token.secret)
  end

  test "list_tokens/0 returns all tokens" do
    token1 = fixture(:token)
    token2 = fixture(:token)

    assert [token1, token2] == Security.list_tokens()
  end

  test "get_token/1 returns token with given id" do
    token = fixture(:token)

    assert token == Security.get_token(token.id)
  end

  test "get_token/1 returns nil when token does not exist with given id" do
    assert nil == Security.get_token(1)
  end

  test "get_token_by_key/1 returns token with given key" do
    token = fixture(:token)

    assert token == Security.get_token_by_key(token.key)
  end

  test "get_token_by_key/1 returns nil if token doesn't exist with given key" do
    assert nil == Security.get_token_by_key("abc")
  end

  test "delete_token/1 deletes given token" do
    token = fixture(:token)

    assert {:ok, _} = Security.delete_token(token)
    assert [] == Security.list_tokens()
  end

  test "valid_token?/2 returns ok when the key and secret are correct" do
    %{key: key, secret: secret} = fixture(:token)

    assert {:ok, :valid} = Security.valid_token?(key, secret)
  end

  test "valid_token?/2 returns error when the key does not exist" do
    assert {:error, :invalid} = Security.valid_token?("abc", "123")
  end

  test "valid_token?/2 returns error when the secret does not match" do
    %{key: key} = fixture(:token)

    assert {:error, :invalid} = Security.valid_token?(key, "invalidtoken")
  end

  test "random_string/1 generates a random string of a given length" do
    string = Security.generate_random_string(64)

    assert 64 == String.length(string)
  end
end
