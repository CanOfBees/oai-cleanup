declare namespace oai = "http://www.openarchives.org/OAI/2.0/";


for $set in fn:doc('http://dpla.lib.utk.edu/repox/OAIHandler?verb=ListSets')/oai:OAI-PMH/oai:ListSets/oai:set
let $spec := $set/oai:setSpec/text()
let $name := $set/oai:setName/text()
return(
  db:add('repox-sets', <set><spec>{$spec}</spec><name>{$name}</name></set>, $name)
)