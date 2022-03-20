parameter: {
    domain: string
    http: [string]: int
}

// trait template can have multiple outputs in one trait
outputs: service: {
    apiVersion: "v1"
    kind:       "Service"
    metadata:
    name: context.name
    labels: {
        "app.kubernetes.io/name": context.name + "-service"
        "app.kubernetes.io/component": "service"
        "app.kubernetes.io/part-of": context.name
    }
    spec: {
    selector:
        "app.oam.dev/component": context.name
    ports: [
        for k, v in parameter.http {
        port:       v
        targetPort: v
        },
    ]
    }
}

outputs: ingress: {
    apiVersion: "networking.k8s.io/v1"
    kind:       "Ingress"
    metadata:
    name: context.name + "-ingress"
    labels: {
        "app.kubernetes.io/name": context.name + "-ingress"
        "app.kubernetes.io/component": "ingress"
        "app.kubernetes.io/part-of": context.name
    }
    spec: {
    rules: [{
        host: parameter.domain
        http: {
        paths: [
            for k, v in parameter.http {
            path: k
            pathType: "ImplementationSpecific"
            backend: {
                service: {
                name: context.name
                port: {
                    number: v
                }
                }
            }
            },
        ]
        }
    }]
    }
}

context: {
    name: "test"
}

parameter: {
    domain: "test.apps.io",
    http: 
        "/": 80
}