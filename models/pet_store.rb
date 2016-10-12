require_relative('../db/sql_runner')

class PetStore

  attr_reader :id
  attr_accessor :name, :address, :stock_type

  def initialize(options)
    @id = options['id'].to_i
    @name = options['name']
    @address = options['address']
    @stock_type = options['stock_type']
  end

  def save()
    sql =
    "INSERT INTO pet_stores (name, address, stock_type) VALUES ('#{@name}', '#{@address}', '#{@stock_type}') RETURNING id"
    pet_store_data = SqlRunner.run(sql).first
    @id = pet_store_data['id']
  end

  def update()
    if @id
      sql =
      "UPDATE pet_stores SET
        name = '#{@name}',
        address = '#{@address}',
        stock_type = '#{@stock_type}'
      WHERE id = #{@id}"
      SqlRunner.run( sql )
    else
      save()
    end
  end

  def delete()
    sql = "DELETE FROM pet_stores WHERE id = #{@id}"
    SqlRunner.run(sql)
  end

  def get_pets()
    sql = "SELECT * FROM pets WHERE pet_store_id = id"
    pets_data = SqlRunner.run( sql )
    return pets_data.map { |pet_data| Pet.new( pet_data )}
  end

  # Matthew did these parts alone:
  
  # def self.find_by_id(id)
  #   sql = "SELECT * FROM pet_stores WHERE id = #{id}"
  #   pet_store_data = SqlRunner.run( sql ).first
  #   return PetStore.new(pet_store_data)
  # end

  # def self.all()
  #   sql = "SELECT * FROM pet_stores"
  #   pet_stores_data = SqlRunner.run( sql )
  #   return pet_stores_data.map { |pet_store_data| PetStore.new( pet_store_data ) }
  # end

  def remove_stock()
    sql = "DELETE FROM pets WHERE pet_store_id = id"
    SqlRunner.run(sql)
  end

end