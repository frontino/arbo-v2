defmodule HojaWeb.EntityControllerTest do
  use HojaWeb.ConnCase

  alias Hoja.Arbo
  alias Hoja.Arbo.Entity

  @create_attrs %{
    entity_type: "class",
    inep: "some inep",
    name: "some name",
    parent_id: nil
  }

  @update_attrs %{
    entity_type: "class",
    inep: "some updated inep",
    name: "some updated name",
    parent_id: nil
  }

  @invalid_attrs %{entity_type: nil, inep: nil, name: nil, parent_id: nil}
  

  def fixture(:entity) do
    {:ok, entity} = Arbo.create_entity(@create_attrs)
    entity
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all entities", %{conn: conn} do
      conn = get(conn, Routes.entity_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create entity" do
    test "renders entity when data is valid", %{conn: conn} do
      conn = post(conn, Routes.entity_path(conn, :create), entity: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]
      
      #conn = get(conn, Routes.entity_path(conn, :show, id))

      assert %{
               "id" => id,
               "entity_type" => "class",
               "inep" => "some inep",
               "name" => "some name",
               "parent_id" => nil
             } = json_response(conn, 201)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.entity_path(conn, :create), entity: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update entity" do
    setup [:create_entity]

    test "renders entity when data is valid", %{conn: conn, entity: %Entity{id: id} = entity} do
      conn = put(conn, Routes.entity_path(conn, :update, entity), entity: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

     # conn = get(conn, Routes.entity_path(conn, :show, id))

      assert %{
               "id" => id,
               "entity_type" => "class",
               "inep" => "some updated inep",
               "name" => "some updated name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, entity: entity} do
      conn = put(conn, Routes.entity_path(conn, :update, entity), entity: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete entity" do
    setup [:create_entity]

    test "deletes chosen entity", %{conn: conn, entity: entity} do
      conn = delete(conn, Routes.entity_path(conn, :delete, entity))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.entity_path(conn, :show, entity))
      end
    end
  end

  defp create_entity(_) do
    entity = fixture(:entity)
    %{entity: entity}
  end
end
