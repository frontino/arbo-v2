defmodule Hoja.ArboTest do
  use Hoja.DataCase

  alias Hoja.Arbo

  describe "entities" do
    alias Hoja.Arbo.Entity

    @valid_attrs %{inep: "some inep", entity_type: "some entity_type", name: "some name"}
    @update_attrs %{inep: "some inep", entity_type: "some updated entity_type", name: "some updated name"}
    @invalid_attrs %{inep: nil, entity_type: nil, name: nil}

    def entity_fixture(attrs \\ %{}) do
      {:ok, entity} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Arbo.create_entity()

      entity
    end

    test "list_entities/0 returns all entities" do
      entity = entity_fixture()
      assert Arbo.list_entities() == [entity]
    end

    test "get_entity!/1 returns the entity with given id" do
      entity = entity_fixture()
      assert Arbo.get_entity!(entity.id) == entity
    end

    test "create_entity/1 with valid data creates a entity" do
      assert {:ok, %Entity{} = entity} = Arbo.create_entity(@valid_attrs)
      assert entity.inep == "some inep"
      assert entity.entity_type == "some entity_type"
      assert entity.name == "some name"
    end

    test "create_entity/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Arbo.create_entity(@invalid_attrs)
    end

    test "update_entity/2 with valid data updates the entity" do
      entity = entity_fixture()
      assert {:ok, %Entity{} = entity} = Arbo.update_entity(entity, @update_attrs)
      assert entity.inep == "some inep"
      assert entity.entity_type == "some updated entity_type"
      assert entity.name == "some updated name"
    end

    test "update_entity/2 with invalid data returns error changeset" do
      entity = entity_fixture()
      assert {:error, %Ecto.Changeset{}} = Arbo.update_entity(entity, @invalid_attrs)
      assert entity == Arbo.get_entity!(entity.id)
    end

    test "delete_entity/1 deletes the entity" do
      entity = entity_fixture()
      assert {:ok, %Entity{}} = Arbo.delete_entity(entity)
      assert_raise Ecto.NoResultsError, fn -> Arbo.get_entity!(entity.id) end
    end

    test "change_entity/1 returns a entity changeset" do
      entity = entity_fixture()
      assert %Ecto.Changeset{} = Arbo.change_entity(entity)
    end
  end
end


