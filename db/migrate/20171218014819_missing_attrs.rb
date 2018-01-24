class MissingAttrs < ActiveRecord::Migration[5.1]
  def change
    change_table :goals do |t|
    	# t.change :time, :integer
    	# NOTA: esta alteração em Postgres / MySQL etc dá erro
    	# PG::DatatypeMismatch: ERROR:  column "time" cannot be cast automatically to type integer
		# a razão é simples, não sabe fazer o cast automático (de DateTime?) para inteiro
		# e como a tabela/coluna pode ter valores importantes ele não os descarta
		# a solução nestes casos seria criar uma nova coluna, converter os dados, apagar
		# a coluna antiga e mudar o nome. Como não há dados reais no vosso projecto
		# vou só corrigir fazendo drop e create.
		t.remove :time
		t.integer :time
    end
  end
end
