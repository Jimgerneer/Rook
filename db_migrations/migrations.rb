require 'dm-migrations'
require 'dm-migrations/migration_runner'

DataMapper.setup(:default, 'postgres://username:password@ec2-107-20-224-107.compute-1.amazonaws.com:5432/dd74kte6km9s1d')

DataMapper::Logger.new(STDOUT, :debug)
DataMapper.logger.debug( "Starting Migration" )

#this throws an error in postgress, doesnt call TYPE correctly
migration 1, :user_bio_to_text do
  up do
    modify_table :users do
      change_column :bio, 'text'
    end
  end
end

migrate_up!
