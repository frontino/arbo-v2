defmodule Hoja.Arbo.Entity do
  use Ecto.Schema
  import Ecto.Changeset

  schema "entities" do
    field :inep, :string
    field :parent_id, :integer
    field :entity_type, :string
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(entity, attrs) do
    entity
    |> cast(attrs, [:name, :entity_type, :inep, :parent_id])
    |> foreign_key_constraint(:parent_id)
    |> unique_constraint(:inep)
    |> validate_required([:name, :entity_type])
  end
end

