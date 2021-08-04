# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Hoja.Repo.insert!(%Hoja.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

IO.puts("Adding a couple of items...")

Hoja.Arbo.create_entity(%{name: "Rede Uniasselvi", entity_type: "network", inep: nil, parent_id: nil })
Hoja.Arbo.create_entity(%{name: "IF Sul", entity_type: "network", inep: nil, parent_id: nil })
Hoja.Arbo.create_entity(%{name: "Uniasselv Pedro Osorio", entity_type: "school", inep: "123-123", parent_id: 1 })
Hoja.Arbo.create_entity(%{name: "IF sul unidade P.O.", entity_type: "school", inep: "123-2", parent_id: 2 })
Hoja.Arbo.create_entity(%{name: "Turma 3A", entity_type: "class", inep: nil, parent_id: 3 })
