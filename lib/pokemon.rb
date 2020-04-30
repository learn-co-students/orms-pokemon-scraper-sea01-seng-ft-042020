class Pokemon
    attr_accessor :id, :name, :type, :db

    def initialize(hash)
        hash.each {|key, value| self.send(("#{key}="), value)}
    end

    def self.save(name, type, db)
        sql = <<-SQL
        INSERT INTO pokemon (name, type) VALUES (?, ?)
        SQL
        db.execute(sql, name, type)
        @id = db.execute("SELECT last_insert_rowid() FROM pokemon")[0][0]
    end

    def self.find(id, db)
        sql = <<-SQL
        SELECT * FROM pokemon WHERE id = ?
        SQL
        hit = db.execute(sql, id)[0]
        Pokemon.new(name: hit[1], type: hit[2], id: id, db: db)
    end
end
