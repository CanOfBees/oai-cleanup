(: add new UTC qdc oai sets to the repox-set list :)

declare namespace oai = "http://www.openarchives.org/OAI/2.0/";

(: run COMMAND `SET INTPARSE true; SET FTINDEX true; CREATE DB utc-qdc-sets` :)

for $set in fn:doc('http://cdm16877.contentdm.oclc.org/oai/oai.php?verb=ListSets')/oai:OAI-PMH/oai:ListSets/oai:set
let $spec := $set/oai:setSpec/text()
let $name := $set/oai:setName/text()
return(
  db:add('utc-qdc-sets', <set><spec>{$spec}</spec><name>{$name}</name></set>, $name)
)