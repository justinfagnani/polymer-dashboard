org=${1:-"kevinpschaaf"}
repo=${2:-"polymer-dashboard"}

polybuild index.html --maximum-crush
echo js:   `gzip -c index.build.js | wc -c`
echo html: `gzip -c index.build.html | wc -c`

rm -rf deploy
git clone -b gh-pages --single-branch git@github.com:$org/$repo.git deploy

mv index.build.html deploy/index.html
mv index.build.js deploy
cp sw.js deploy
polybuild index-debug.html --maximum-crush
mv index-debug.build.html deploy/index-debug.html
mv index-debug.build.js deploy

cp callback.html deploy
rm -rf deploy/resources
cp -rf resources deploy

pushd deploy >/dev/null
git add -A .
git commit -am 'update gh-pages'
git push -u origin gh-pages:gh-pages
popd >/dev/null