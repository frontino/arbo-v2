defmodule HojaWeb.EntityController do
  use HojaWeb, :controller

  alias Hoja.Arbo
  alias Hoja.Arbo.Entity

  action_fallback HojaWeb.FallbackController

  def index(conn, _params) do
    entities = Arbo.list_entities()
    render(conn, "index.json", entities: entities)
  end

  def create(conn, %{"entity" => entity_params}) do
    with {:ok, %Entity{} = entity} <- Arbo.create_entity(entity_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.entity_path(conn, :show, entity))
      |> render("show.json", entity: entity)
    end
  end

  def show(conn, %{"id" => id}) do
    entity = Arbo.get_entity!(id)
    parents_id = Arbo.get_parents!(id, entity.entity_type)
    arbo_subtree = parents_id.rows
    arbo_subtree_ids = Enum.map(arbo_subtree, fn [ids] -> ids end)

    json(conn, %{
      id: entity.id,
      name: entity.name,
      entity_type: entity.entity_type,
      inep: entity.inep,
      parent_id: entity.parent_id,
      subtree_ids: arbo_subtree_ids
    })
  end

  def update(conn, %{"id" => id, "entity" => entity_params}) do
    entity = Arbo.get_entity!(id)

    with {:ok, %Entity{} = entity} <- Arbo.update_entity(entity, entity_params) do
      render(conn, "show.json", entity: entity)
    end
  end

  def delete(conn, %{"id" => id}) do
    entity = Arbo.get_entity!(id)

    with {:ok, %Entity{}} <- Arbo.delete_entity(entity) do
      send_resp(conn, :no_content, "")
    end
  end
end
