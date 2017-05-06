import module namespace functx = 'http://www.functx.com';

let $target := '/mnt/gwork/repox-data/'
let $coll := 'crossroadsfreedom'

for $record in db:open($coll)/record[descendant::*:format[contains(., '6.5 inch metal-based acetate disc')
                                                          or contains(., '10 inch metal-based acetate disc')
                                                          or contains(., '8 inch metal-based acetate disc')]]

let $file-full := functx:substring-after-last(db:path($record), ':')
let $file := if (fn:contains($file-full, '/'))
             then (fn:replace($file-full, '/', '_'))
             else $file-full
let $path := $target || $coll || '/' || $file || '.xml'(: db:path($record) :)
return (
  file:create-dir(file:parent($path)),
  file:write($path, $record)
)