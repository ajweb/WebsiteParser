require 'csvProcess.rb'

nombresCats = ProcessCSV.new('/Users/angeljusto/PROYECTOS_A/lanautica/insercion_masiva_productos/OSCULATI/OSCULATI_OK/osculati_importaciones_productos/osculati_todo_limpio__clean.csv', '|')
# idsCats = ProcessCSV.new('/Users/angeljusto/Desktop/categories_table_listo_insercion.csv', '|')


catsNames = nombresCats.makeHash(13,1)

subcatsNames = nombresCats.makeHash(15,2)

subcatsNames.merge!(catsNames)

nombresCats.newCSVArray = []

subcatsNames.each do |val,id|
	unless nombresCats.newCSVArray.flatten.include? val	
		nombresCats.newCSVArray.push []
		nombresCats.newCSVArray[-1].push id 
		nombresCats.newCSVArray[-1].push val 
	end
end	


# puts categorias.inspect	
nombresCats.writeNewCSV('/Users/angeljusto/Desktop/osculati_nuevas_categorias_italian.csv')