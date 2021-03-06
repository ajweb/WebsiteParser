require 'url.rb'
require 'osculati.rb'
require 'csvOutput.rb'
require 'csvProcess.rb'

p = ProcessCSV.new('/Users/angeljusto/Desktop/productos_sin_imagen_osculati-products.csv', '|')

ya_hechas = ProcessCSV.new('/Users/angeljusto/Desktop/imagenes_encontradas_1_modelos.csv', ',')

# guardado de lo encontrado
retriever = Osculati.new( CsvOutput.new('/Users/angeljusto/Desktop/imagenes_osculati_faltan.csv'))

retriever.logOutput = CsvOutput.new('/Users/angeljusto/Desktop/images_faltan_log.csv')
retriever.addFollow('table.risultati td a') # subcategorias
retriever.addElements('#ctl00_ContentPlaceHolder1_fwScheda_hlImg1')
retriever.directOutputLogging = true

# id, categoria
id_to_category = p.makeHash(0,2)
id_to_modelo = p.makeHash(0,1)

# puts ya_hechas.newCSVArray.inspect

i=1
id_to_category.each_pair do |id,cat|
  retriever.string_a_buscar = id_to_modelo[id]
  unless ya_hechas.newCSVArray.flatten.include? id_to_modelo[id]
    puts id_to_modelo[id]
    url = Url.new('http://www.osculati.com/cat/Serieweb.aspx?id='+cat)
    retriever.parsePage(url)
    puts url.url
  end
    puts i
    i=i+1 
end
