class Pokemon
    attr_reader :id
    attr_accessor :name, :type, :db

    def initialize(id: nil, name: , type:, db:)
        @id = id
        self.name = name
        self.type = type
        @db = db
    end

    def self.save(id = nil, name, type, db)
        Pokemon.new(id: id, name: name, type: type, db: db).save
    end

    def save
        # Check if this is already in the database table, if it is just update existing.
        if self.id
            self.update
        # Its not in the database table, save values
        else
            sql = <<-SQL
                INSERT INTO pokemon (name, type)
                VALUES (? ,?)
                SQL
            self.db.execute(sql, [self.name, self.type,])
            @id = self.db.execute("SELECT last_insert_rowid() FROM pokemon").first.first
            self
        end
    end

    def update
        sql = <<-SQL
            UPDATE pokemon
            SET name = ?, type = ?
            WHERE id == ?
            SQL
        self.db.execute(sql, [self.name, self.type, self.id])
        self
    end  

    def self.find(pk_id, pk_db)
        sql = <<-SQL
            SELECT * FROM pokemon
            WHERE id == ?
            SQL
        new_pokemon = pk_db.execute(sql, [pk_id]).first
        self.save(new_pokemon[0], new_pokemon[1], new_pokemon[2], pk_db)
    end
end
