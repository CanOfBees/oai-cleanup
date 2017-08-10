declare namespace oai = "http://www.openarchives.org/OAI/2.0/";

(: Retrieves metadata records for an entire OAI-PMH collection :)
(: Adds records to BaseX database:)

declare function local:request($base-url as xs:string, $verb as xs:string) as document-node()*
{
    let $request := $base-url || $verb 
    let $response := fn:doc($request)
    let $token := $response//oai:resumptionToken/text()
    return
        if (fn:empty($token)) then
            $response
        else
            ($response,
            local:resume($base-url, $token))
};

declare function local:resume($base-url as xs:string, $token as xs:string) as document-node()*
{
    let $verb := "?verb=ListRecords&amp;resumptionToken="
    let $request := $base-url || $verb || $token
    let $response := fn:doc($request)
    let $new-token := $response//oai:resumptionToken/text()
    return
        if (fn:empty($new-token)) then
            $response
        else
            ($response,
            local:resume($base-url, $new-token))
};

let $base-url := "http://dpla.lib.utk.edu/repox/OAIHandler"
let $verb := "?verb=ListRecords&amp;metadataPrefix=MODS"
let $response := local:request($base-url, $verb)
for $record in $response//oai:record
let $id := $record/oai:header/oai:identifier/text()
return(
  (: db:replace('cmhf', $record, $id, map { 'addcache': true() }) :)
  db:add('all-records', $record, $id, map { 'addcache': true() }),
  db:optimize('all-records', true(), map { 'textindex': true(), 'attrindex': true(), 'tokenindex': true(), 'ftindex': true() })
)