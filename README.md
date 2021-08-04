# Árvore Backender Test

* Autor: Frontino Costa Caldeira Junior
* Objetivo: Construir uma API usando Phoenix (elixir) e banco de dados MySQL visando permitir a um
parceiro da Árvore replicar a sua estrutura de Redes, Escolas, Turmas e administrá-la
conforme necessário.
A modelagem deverá utilizar apenas uma entidade (Entity), que poderá representar
qualquer nível da estrutura hierárquica.

------------

Projeto desenvolvido utilizando a linguagem de programação [Elixir](https://elixir-lang.org/ "Elixir"), juntamente com o framework [Phoenix](https://www.phoenixframework.org/ "Phoenix") para a criação da API.

Requisitos Mínimos:
- [x] Documentação do repositório git;
- [x] Histórico de commits;
- [x] Testes unitários;

Requisitos Desejáveis:
- [x] - Deploy em qualquer serviço para consumo durante avaliação

Ferramentas:
* Elixir: 1.12.2 (compiled with Erlang/OTP 22)
* Erlang/OTP: 24.0.5
* Phoenix: v1.5.9
* MySQL: 8.0.26 for Linux on x86_64

Clone o repositório com o seguinte comando:

`git clone https://github.com/frontino/arbo-v2.git`

Com o repositório em sua máquina, entre na pasta `arbo-v2`

```    
cd arbo-v2/
```

Primeiramente, é necessário ter uma instância do MySQL pronta para uso, para poder consumir a base de dados, é necessário configurar os parâmetros para conexão dentro do projeto.

Dentro da pasta do projeto, na pasta `config`, abra os arquivos `dev.exs` e `test.exs` e edite da seguinte maneira:

`dev.exs`
```elixir
config :hoja, Hoja.Repo,
  username: <seu_usuario>,
  password: <sua_senha>,
  database: "hoja_dev",
  hostname: "localhost",
  show_sensitive_data_on_connection_error: true,
  pool_size: 10
```

`test.exs`
```elixir
config :hoja, Hoja.Repo,
  username: <seu_usuario>,
  password: <sua_senha>
  database: "hoja_test#{System.get_env("MIX_TEST_PARTITION")}",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

```

Para iniciar seu servidor Phoenix:

* Instale as dependências com `mix deps.get`
* Crie e migre sua base de dados com `mix ecto.setup`
* Inicie o servidor com `mix phx.server`
* Para executar os testes unitários:`mix test`

Obs: dentro do projeto, na pasta `priv/seeds.exs`, há um arquivo para alimentar a base com alguns dados de início, ao rodar o comando `mix ecto.setup` ou `mix ecto.reset`, o arquivo será lido, e os dados inseridos.

Agora você pode começar a consumir os endpoints no endereço `localhost:4000/api/entities`

## Deploy

O deploy da aplicação foi feito utilizando AWS composto de uma instância VM com Ubuntu 18.04, e uma instância de banco de dados como serviço utilizando MySQL na versão especificada.

Obs: Esta estrutura atende apenas como ambiente de testes. Em ambientes de produção, o recomendado é utilizar clusterização, com load balancer.

Para consumir os endpoints da aplicação, basta acessar o seguinte endereço e seguir os modelos de requisição dentro da seção [Endpoints](##Endpoints)

http://justaleaf.hopto.org:4000/api/entities


------------

## Endpoints 
Para o consumo dos endpoints é possível utilizar ferramentas como o [Postman](https://www.postman.com/ "Postman") ou o [Insomnia](https://insomnia.rest/download "Insomnia") ou diretamente com `curl` via terminal.

- Criação de  entidade (entity):

http://localhost:4000/api/entities
POST request: 

```json
{
    "entity": {
        "name": "Uniasselv Pedro Osorio",
        "entity_type": "school",
        "inep": "123-123",
        "parent_id": 1
    }
}
```
Response:
```json
{
    "data": {
        "entity_type": "school",
        "id": 3,
        "inep": "123-123",
        "name": "Uniasselv Pedro Osorio",
        "parent_id": 1
    }
}

```

------------

- Edição de uma entidade (entity): 

http://localhost:4000/api/entities/3    onde 3 é o id passado para a alteração
PUT request:
```json
{
    "entity": {
  "entity_type": "school",
  "id": 3,
  "inep": "123-123",
  "name": "Uniasselvi Pedro Osorio",
  "parent_id": 1
}
}

```

Response:
```json
{
  "data": {
    "entity_type": "school",
    "id": 3,
    "inep": "123-123",
    "name": "Uniasselvi Pedro Osorio",
    "parent_id": 1
  }
}
```

------------

- Exibição de uma entidade (por id)

GET request:
http://localhost:4000/api/entities/1 onde 1 é o id passado para pesquisa
```json
{
  "entity_type": "network",
  "id": 1,
  "inep": null,
  "name": "Rede Uniasselvi",
  "parent_id": null,
  "subtree_ids": [
    3
  ]
}
```
