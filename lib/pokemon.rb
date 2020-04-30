class Pokemon

    attr_accessor :name, :type
    attr_reader :id, :db

    def initialize (name:, type:, db:, id:nil)
        @id = id
        @name = name
        @type = type
        @db = db 
    end

    def self.save(name, type, db)
        db.execute("INSERT INTO pokemon (name, type) VALUES (?,?)", name, type)
    end 

    def self.find(id, db)
        # binding.pry
        pokemon_from_db = db.execute("SELECT * FROM pokemon WHERE pokemon.id = ?", id)
        id = pokemon_from_db[0][0]
        name = pokemon_from_db[0][1]
        type = pokemon_from_db[0][2]
        new_pokemon = Pokemon.new({name: name, type: type, db: db, id: id})
        new_pokemon
    end
end