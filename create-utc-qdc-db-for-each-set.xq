(: 
  this xquery script creates a database for each of the sets in the ListSets
  response.
:)

for $set in db:open('utc-qdc-sets')/set/spec/text()
return
  db:create(($set || "_qdc"), (), (), map { 'textindex': true(), 'attrindex': true(), 'tokenindex': true(), 'ftindex': true() } )