import module namespace functx = 'http://www.functx.com';

let $target := '/tmp/utc_p16877coll16/'
for $record in db:open('utc_p16877coll16')/record[not(header/identifier[contains(., 'p16877coll16/24')])]
let $file-full := functx:substring-after-last(db:path($record), ':')
let $file := if (fn:contains($file-full, '/'))
             then (fn:replace($file-full, '/', '_'))
             else $file-full
let $path := $target || $file || '.xml'(: db:path($record) :)
return (
  (: file:create-dir(file:parent($path)),
  file:write($path, $record) :)
  (:file:create-dir(file:parent($path)),
  file:write($path, $record):)
  $path
)