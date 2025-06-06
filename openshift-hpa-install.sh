oc new-project hpa-project
oc apply -f manifests/backend-v1.yaml -n hpa-project
oc apply -f manifests/backend-service.yaml -n hpa-project
oc apply -f manifests/backend-route.yaml -n hpa-project
oc set env deployment backend-v1 -n hpa-project APP_BACKEND=https://httpbin.org/status/200
oc wait --for=condition=ready --timeout=60s pod -l app=backend
BACKEND_URL=http://$(oc get route backend -n hpa-project -o jsonpath='{.spec.host}')
curl -v -k $BACKEND_URL
oc apply -f manifests/backend-cpu-hpa.yaml -n hpa-project
watch oc get horizontalpodautoscaler/backend-cpu -n hpa-project
