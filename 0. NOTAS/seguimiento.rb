Se crea el proyecto: -> rails new Rails-Cards -T

Se cambia de BD -> rails db:system:change --to=postgresql

Se agregan gemas de HAML para optimizar el codigo:

gem 'hamlit'
#En development
gem 'hamlit-rails' 

Se agrega gema de simple_form

gem "simple_form"

Se ejecutan los comandos para vincular las vistas a bootstrap (Segun lo que entendi)

rails generate simple_form:install

rails g simple_form:install --bootstrap

#! Configuramos el acceso a postgresql

rails db:create

en config/locales/database.yml configuramos en las secciones development y test lo siguiente

host: localhost
user: jehicoob
password: 1980

#! Creando los primero scaffolds

# Categorias
rails g scaffold Category name:string description:string

# Decks
# rails g scaffold Deck code:string name:string description:text category:references user:references # Se modifico cuando ya etaba creado el usuario (devise)
rails g scaffold Deck name:string description:text category:references # Se modifico cuando ya etaba creado el usuario (devise)

# Cards
# rails g scaffold Card question:text description:text deck:references user:references # Se modifico cuando ya etaba creado el usuario (devise)
rails g model Card question:text description:text deck:references user:references # Se modifico cuando ya etaba creado el usuario (devise)

Se ejecutan las migraciones -> rails db:migrate

Para tener mas info sobre los modelos agregamos la gema:

gem "annotate"

annotate --models

#! Añadiendo Usuario - Inicio de sesion

Añadimos la gema

gem "devise"

rails g devise:install

create  config/initializers/devise.rb
create  config/locales/devise.en.yml

rails g devise User -> Para crear el modelo Usuario (con sus migraciones)

Se ejecutan las migraciones -> rails db:migrate

Se crea un controlador para el index

rails g controller welcome index

Se generan las vistas del devise 

rails g devise:views






:string, :text, :integer, :float, :decimal, :datetime, :timestamp, :time, :date, :binary, :boolean

carrierwave gem

rails g model CardScore user:references deck:references card:references total_score:float plays:integer average:float
rails g model DeckScore user:references deck:references score:float qualification:float successful_cards:integer

    # score = DeckScore.create(
    #   user_id: @owner.id,
    #   score: 0.0,
    #   qualification: 0.0,
    #   successful_cards: 0
    # )

    # @deck.deck_scores << score

    # score = DeckScore.create(
    #   user_id: @owner.id,
    #   score: 0.0,
    #   qualification: 0.0,
    #   successful_cards: 0
    # )