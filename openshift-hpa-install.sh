oc new-project project1
oc apply -f manifests/backend-v1.yaml -n project1
oc apply -f manifests/backend-service.yaml -n project1
oc apply -f manifests/backend-route.yaml -n project1
oc set env deployment backend-v1 -n project1 APP_BACKEND=https://httpbin.org/status/200
oc wait --for=condition=ready --timeout=60s pod -l app=backend -n project1
BACKEND_URL=http://$(oc get route backend -n project1 -o jsonpath='{.spec.host}')
curl -v -k $BACKEND_URL
oc apply -f manifests/backend-cpu-hpa.yaml -n project1
#watch oc get horizontalpodautoscaler/backend-cpu -n project1
