# Prueba final - Escuela Testing

[Swagger Petstore](https://petstore.swagger.io)

# Módulo Store

### Happy Path

Se validan los siguientes flujos funcionales:

1. Consultar inventario (`GET /store/inventory`)
2. Crear orden (`POST /store/order`)
3. Buscar orden por ID (`GET /store/order/{id}`)
4. Eliminar orden (`DELETE /store/order/{id}`)

Las órdenes se parametrizan usando múltiples JSON:

- store-order.json
- store-order-2.json

---

## Unhappy Path

Se evaluaron escenarios negativos relevantes:

### Búsqueda de orden eliminada
- Se valida que el sistema retorne 404.
- Se verifica mensaje `"Order not found"`.

### ID fuera de rango
- IDs mayores a 10
- IDs negativos
- IDs inexistentes

### Creación de orden sin body

El endpoint acepta `{}` y responde `200 OK`. (falta de validación)

### Creación con payload incompleto
El endpoint permite crear órdenes con:
- Solo `id`
- Solo `petId`
- Solo `quantity`
- Solo `shipDate`
- `status` incluso como booleano

No existe estrictas validaciones de negocio

---

## Ejecución

### Ejecutar todos los tests Store

```bash
mvn clean test -Dtest=StoreRunner -Dkarate.options="--tags @regression" -Dkarate.env=dev
```

### Ejecutar un test
```bash
mvn clean test -Dtest=StoreRunner -Dkarate.options="--tags @TEST-01" -Dkarate.env=dev
```

---

## Estructura del Proyecto
```
└── 📁src
    └── 📁test
        └── 📁java
            └── 📁examples
                └── 📁store
                    ├── store.feature
                    ├── StoreRunner.java
                └── 📁user
                    ├── user.feature
                    ├── UserRunner.java
                ├── ExamplesTest.java
            └── 📁resources
                └── 📁examples
                    └── 📁data
                        └── 📁store
                        └── 📁user
            ├── karate-config.js
            └── logback-test.xml
```