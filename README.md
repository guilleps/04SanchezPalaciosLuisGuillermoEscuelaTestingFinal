# Prueba final - Escuela Testing

[Swagger Petstore](https://petstore.swagger.io)

### Store
```bash
mvn clean test -Dtest=StoreRunner -Dkarate.options="--tags @TEST-1" -Dkarate.env=dev
```

### User
```bash
mvn clean test -Dtest=UserRunner -Dkarate.options="--tags @TEST-1" -Dkarate.env=dev
```

mvn clean test -Dtest=UsersRunner -Dkarate.options="--tags @regresion" -Dkarate.env=dev

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
            ├── karate-config.js
            └── logback-test.xml
```