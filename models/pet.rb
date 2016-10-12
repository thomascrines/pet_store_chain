require_relative('../db/sql_runner')

class Pet

  attr_reader :id
  attr_accessor :name, :type, :pet_store_id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @type = options['type']
    @pet_store_id = options['pet_store_id']
  end

  def save()
    sql =
    "INSERT INTO pets(name, type, pet_store_id)
      VALUES (
        '#{@name}',
        '#{@type}',
        #{pet_store_id}
      ) RETURNING id"
    result = SqlRunner.run( sql ).first
    @id = result['id']
  end

  def delete()
    sql = "DELETE FROM pets WHERE id = #{@id}"
    SqlRunner.run( sql )
  end

  def pet_store()
    sql = "SELECT * FROM pet_stores WHERE id = #{@pet_store_id}"
    pet_store_data = SqlRunner.run(sql).first
    return PetStore.new(pet_store_data)
  end

  # Matthew did the next two alone...

  def self.find_by_id(id)
    sql = "SELECT * FROM pets WHERE id = #{id}"
    pet_data = SqlRunner.run( sql ).first
    return Pet.new(pet_data)
  end

  def self.all()
    sql = "SELECT * FROM pets"
    pets_data = SqlRunner.run( sql )
    return pets_data.map { |pet_data| PetStore.new( pet_data ) }
  end

end
