let $target := '/tmp/utc_p16877coll16_2/'
for $record in db:open('utc_p16877coll16')/record[not(header/identifier[contains(., 'p16877coll16/24')])]
let $path := $target || db:path($record) || '.xml'
return
  db:export('utc_p16877coll16', $path, map { 'method': 'xml', 'encoding': 'UTF-8', 'indent': 'yes', 'omit-xml-declaration': 'no' })