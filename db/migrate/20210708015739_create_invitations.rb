class CreateInvitations < ActiveRecord::Migration[5.2]
  def change
    create_table :invitations do |t|
      t.belongs_to :movie_party, foreign_key: true
      t.belongs_to :friendship, foreign_key: true
    end
  end
end
