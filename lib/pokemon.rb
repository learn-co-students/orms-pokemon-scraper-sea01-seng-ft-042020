class Pokemon
    attr_accessor :id, :name, :type, :db

    def initialize(id:, name:, type:, db:)
        @id = id
        @name = name
        @type = type
        @db = db
    end

    def self.save(name, type, db)
        sql = <<-SQL
        INSERT INTO pokemon (name, type)
        VALUES (?, ?)
        SQL

        db.execute(sql, name, type)
    end

    def self.find(id, db)
        self.all(db).find {|pokemon| pokemon.id == id}
    end

    def self.all(db)
        sql = <<-SQL
        SELECT *
        FROM pokemon
        SQL

        pokemon = db.execute(sql)
        pokemon = pokemon.map {|pokemon| {id:pokemon[0], name:pokemon[1], type:pokemon[2], db:db}}
        pokemon = pokemon.map {|pokemon| Pokemon.new(pokemon)}
        pokemon
    end
end