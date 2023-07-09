#!/bin/bash -e

# https://web.archive.org/web/20140910193725id_/http://www.pltgames.com/competition/2012/12
# https://web.archive.org/web/20141024032101id_/http://www.pltgames.com/competition/2013/1
# https://web.archive.org/web/20140909011337id_/http://www.pltgames.com/competition/2013/2
# https://web.archive.org/web/20140909011342id_/http://www.pltgames.com/competition/2013/3

curl 'https://web.archive.org/web/20140910193725id_/http://www.pltgames.com/competition/2012/12' |
pup '.twelve.columns:nth-child(4) json{}' |
jq -r '
def stars:
  { onestar: 1, twostar: 2, threestar: 3, fourstar: 4, fivestar: 5 }[.children[0].class];

.[0].children[1:] | map(.children | {
  name: .[0].children[0].text,
  user: .[1].children[0].text,
  repo_url: .[0].children[0].href,
  user_url: .[1].children[0].href,
  innovation: .[3] | stars,
  completeness: .[5] | stars,
  theme: .[7] | stars,
}) |
sort_by(-(.innovation + .completeness + .theme), (.name | ascii_downcase))[] |
"| [\(.name)](\(.repo_url)) | [\(.user)](\(.user_url)) | \(.innovation) | \(.completeness) | \(.theme) | \(.innovation + .completeness + .theme) |"
'
