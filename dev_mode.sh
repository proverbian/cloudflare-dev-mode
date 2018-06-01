#!/bin/sh
email=shiloh@codeoptimizer.co
tkn=f05a34c394b09437f3502be38390e6095c2c4
domain=$1
 
zone=$(curl -s -X GET "https://api.CloudFlare.com/client/v4/zones?name=${domain}&status=active&page=1&per_page=20&order=status&direction=desc&match=all" \
-H "X-Auth-Email: ${email}" \
-H "X-Auth-Key: ${tkn}" \
-H "Content-Type: application/json")
 
zone=${zone:18:32}
 
curl -X DELETE "https://api.CloudFlare.com/client/v4/zones/${zone}/purge_cache" \
-H "X-Auth-Email: ${email}" \
-H "X-Auth-Key: ${tkn}" \
-H "Content-Type: application/json" \
--data '{"purge_everything":true}'
 
curl -X PATCH "https://api.cloudflare.com/client/v4/zones/${zone}/settings/development_mode" \
     -H "X-Auth-Email: ${email}" \
     -H "X-Auth-Key: ${tkn}" \
     -H "Content-Type: application/json" \
     --data '{"value":"on"}'
 
unset zone email tkn domain
