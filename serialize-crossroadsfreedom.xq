import module namespace functx = 'http://www.functx.com';

declare namespace oai_dc = "http://www.openarchives.org/OAI/2.0/oai_dc/";
declare namespace dc = "http://purl.org/dc/elements/1.1/";

let $target := '/tmp/'
let $coll := 'crossroadsfreedom'

for $record in db:open($coll)/record
    [(fn:exists(metadata/oai_dc:dc/dc:title)) and 
     (every $t in metadata/oai_dc:dc/dc:title 
      satisfies $t[not(normalize-space(.) = '')])]
    [(fn:exists(metadata/oai_dc:dc/dc:rights)) and
     (every $r in metadata/oai_dc:dc/dc:rights 
      satisfies $r[not(normalize-space(.) = '')])]
    [(fn:exists(metadata/oai_dc:dc/dc:identifier)) and
     (some $i in metadata/oai_dc:dc/dc:identifier 
      satisfies $i[starts-with(., 'http://')])]/metadata/oai_dc:dc

let $file-full := functx:substring-after-last(db:path($record), ':')
let $file := if (fn:contains($file-full, '/'))
             then (fn:replace($file-full, '/', '_'))
             else $file-full
let $path := $target || 'crossroadsfreedom' || '/' || $file || '.xml'
return (
  file:create-dir(file:parent($path)),
  file:write($path, $record, map { "method": "xml",
                                   "encoding": "UTF-8",
                                   "indent": "yes",
                                   "omit-xml-declaration": "no" }
  )
)