import module namespace functx = 'http://www.functx.com';

declare namespace oai_qdc = "http://worldcat.org/xmlschemas/qdc-1.0/";

let $target := '/tmp/repox-data/'
let $coll := 'country_music_qdc'

for $record in db:open($coll)/record[
  descendant::*:format[
    fn:contains(., '6.5 inch metal-based acetate disc')
    or fn:contains(., '10 inch metal-based acetate disc')
    or fn:contains(., '8 inch metal-based acetate disc')
    ]
  ]/*:metadata/oai_qdc:qualifieddc

let $file-full := functx:substring-after-last(db:path($record), ':')
let $file := if (fn:contains($file-full, '/'))
             then (fn:replace($file-full, '/', '_'))
             else $file-full
let $path := $target || 'cmhf' || '/' || $file || '.xml'
return (
  file:create-dir(file:parent($path)),
  file:write($path, 
             $record, 
             map { "method": "xml", 
                   "encoding": "UTF-8",
                   "indent": "yes", 
                   "omit-xml-declaration": "no"}
  )
)