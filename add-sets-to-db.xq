(: preface this with a COMMAND: `set addcache true; create db OAI` :)
(: grab oai-pmh from repox :)
declare namespace oai = "http://www.openarchives.org/OAI/2.0/";

(: Retrieves metadata records for an entire OAI-PMH collection :)
(: Adds records to BaseX database:)

declare function local:request($base-url as xs:string, $verb as xs:string, $set-spec as xs:string) as document-node()*
{
    let $request := $base-url || $verb || $set-spec
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

for $set in db:open('utc-qdc-sets')/set/spec/text()
let $base-url := "http://cdm16877.contentdm.oclc.org/oai/oai.php" (: UTC's ContentDM install :)
let $verb := "?verb=ListRecords&amp;metadataPrefix=oai_qdc"
let $set-spec := "&amp;set=" || $set 
let $response := local:request($base-url, $verb, $set-spec)
for $record in $response//oai:record
let $id := $record/oai:header/oai:identifier/text()
return(
  db:add(($set || "_qdc"), $record, $id, map { 'addcache': true() } ),
  db:optimize(($set || "_qdc"), true())
)