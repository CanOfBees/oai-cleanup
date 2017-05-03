(: 
  this xquery script creates a database for each of the sets in the ListSets
  response.
:)

for $set in db:open('repox-sets')/set/spec/text()
return
  db:create(($set), (), (), map { 'textindex': true(), 'attrindex': true(), 'tokenindex': true(), 'ftindex': true() } )