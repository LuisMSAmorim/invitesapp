Passo para setup do projeto:

- git clone git@github.com:LuisMSAmorim/invitesapp.git
- $ docker-compose up --build
- abra uma nova aba no terminal e execute o comando: make bash
- $ bin/rails db:create
- $ bin/rails db:migrate
- $ bin/rails db:seed

Para rodar os testes:
- $ bin/rails db:create RAILS_ENV=test
- $ bin/rails db:migrate RAILS_ENV=test
- $ rspec
  
