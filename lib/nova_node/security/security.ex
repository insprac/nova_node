defmodule NovaNode.Security do
  import Ecto.Query

  alias NovaNode.Repo
  alias NovaNode.Security.Token

  def list_tokens do
    Repo.all(Token)
  end

  def get_token(id) do
    Repo.get(Token, id)
  end

  def get_token_by_key(key) do
    Repo.one(from t in Token, where: t.key == ^key)
  end

  def create_token(attrs) do
    %Token{}
    |> Token.changeset(attrs)
    |> Repo.insert()
  end

  def create_random_token do
    create_token(%{
      key: generate_random_string(32),
      secret: generate_random_string(64)
    })
  end

  def delete_token(%Token{} = token) do
    Repo.delete(token)
  end

  def valid_token?(key, secret) do
    case get_token_by_key(key) do
      nil ->
        {:error, :invalid}
      token ->
        case token.secret == secret do
          true -> {:ok, :valid}
          false -> {:error, :invalid}
        end
    end
  end

  def generate_random_string(string_length) do
    :crypto.strong_rand_bytes(string_length)
    |> Base.url_encode64()
    |> binary_part(0, string_length)
  end
end
