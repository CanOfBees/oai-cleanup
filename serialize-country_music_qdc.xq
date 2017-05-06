import module namespace functx = 'http://www.functx.com';

let $target := '/mnt/gwork/repox-data/'
let $coll := 'country_music'

for $record in db:open($coll)/record[descendant::*:format[fn:contains(., '6.5 inch metal-based acetate disc')
                                                          or fn:contains(., '10 inch metal-based acetate disc')
                                                          or fn:contains(., '8 inch metal-based acetate disc')]]

let $file-full := functx:substring-after-last(db:path($record), ':')
let $file := if (fn:contains($file-full, '/'))
             then (fn:replace($file-full, '/', '_'))
             else $file-full
let $path := $target || $coll || '/' || $file || '.xml'
return (
  file:create-dir(file:parent($path)),
  file:write($path, $record)
)