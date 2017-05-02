(: this xquery script :)

for $set in db:open('repox-sets')/set/spec/text()
return
  db:create(($set), (), (), map { 'textindex': true(), 'attrindex': true(), 'tokenindex': true(), 'ftindex': true() } )