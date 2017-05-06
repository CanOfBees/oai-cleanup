(: some helpful queries :)

for $name in db:open('repox-sets')/set/spec/text() return db:open($name)/*:record[//@*='deleted']/*:header/*:identifier/text(),

for $name in db:open('repox-sets')/set/spec/text() return db:open($name)/*:record[*:header/*:identifier[fn:contains(.,'p265301coll005/7')]],

for $name in db:open('repox-sets')/set/spec/text() return db:open($name)/*:record[*:header/*:identifier[fn:contains(.,'p18877coll16/24')]],

for $record in db:open('utc_p16877coll16')/record[not(header/identifier[contains(., 'p18877coll16/24')])] return (1 to 3),

let $target := '/tmp/utk_p16877coll16'
for $record in db:open('utc_p16877coll16')/record[not(header/identifier[contains(., 'p16877coll16/24')])]
let $path := $target || db:path($record)
return (
  file:create-dir(file:parent($path)),
  file:write($path, $record)
),

for $name in db:open('repox-sets')/set/spec/text() return db:open($name)/record/header/identifier/text(),

//record[descendant::*:format[matches(., '17 inch metal-based acetate disc')] and descendant::*:format[matches(., '33 1/3 rpm; 78 rpm')]]