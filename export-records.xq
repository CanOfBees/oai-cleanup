(: db:export to a directory structure in /ghome/bridger :)
import module namespace fnx = 'http://www.functx.com'; 

let $target := '/mnt/ghome/repox-export/'

for $set-name in db:open('repox-sets')/set/spec/text()
let $output-dir := $target || $set-name
return (
  file:create-dir($output-dir),
  for $doc in db:open($set-name)
  let $file-name := if (fn:contains($doc/record/header/identifier/text(), '/'))
                    then (fn:substring-after($doc/record/header/identifier/text(), '/') || '.xml')
                    else (fnx:substring-after-last-match($doc/record/header/identifier/text(), ':') || '.xml')
  return (
    file:write($output-dir || '/' || $file-name, $doc) 
  )
)
