defmodule HojaWeb.EntityView do
  use HojaWeb, :view
  alias HojaWeb.EntityView

  def render("index.json", %{entities: entities}) do
    %{data: render_many(entities, EntityView, "entity.json")}
  end

  def render("show.json", %{entity: entity}) do
    %{data: render_one(entity, EntityView, "entity.json")}
  end

  def render("entity.json", %{entity: entity}) do
    %{
      id: entity.id,
      name: entity.name,
      inep: entity.inep,
      entity_type: entity.entity_type,
      parent_id: entity.parent_id}
  end
end
