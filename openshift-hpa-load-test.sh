URL=http://backend.project1:8080
oc run load-test -n project1 -i \
--image=loadimpact/k6 --rm=true --restart=Never \
--  run -  < manifests/load-test-k6.js \
-e URL=$URL -e THREADS=50 -e DURATION=3m -e RAMPUP=30s -e RAMPDOWN=30s