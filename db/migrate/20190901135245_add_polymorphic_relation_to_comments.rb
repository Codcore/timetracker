class AddPolymorphicRelationToComments < ActiveRecord::Migration[5.2]
  def change
    remove_column :comments, :project_id
    add_reference :comments, :commentable, polymorphic: true, index: true
  end
end
