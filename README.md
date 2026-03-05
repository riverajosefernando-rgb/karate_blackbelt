# 🥋 Karate Blackbelt – Advanced API Automation Framework

## Overview

**Karate_blackbelt** is an advanced **API automation testing framework** built using:

* **Karate DSL**
* **Java 17**
* **Gradle**
* **JUnit 5**

The project demonstrates **enterprise-level automation practices** including:

* Environment-based configuration
* Centralized authentication management
* Reusable features
* Externalized test data
* Dynamic data generation
* JSON schema contract validation
* Modular architecture

The goal of this framework is to simulate how **professional SDET / QA Automation frameworks** are designed in real projects.

---

# Technologies and Tools

| Technology    | Purpose                               |
| ------------- | ------------------------------------- |
| Java 17       | Runtime                               |
| Karate DSL    | API testing framework                 |
| Gradle        | Build and dependency management       |
| JUnit 5       | Test execution                        |
| JSON          | Test data format                      |
| JavaScript    | Utility functions and transformations |
| IntelliJ IDEA | Recommended IDE                       |
| Git           | Version control                       |

---

# Project Architecture

```
src
└── test
    ├── java
    │   └── runners
    │       TestRunner.java
    │
    └── resources
        ├── features
        │   ├── auth
        │   │   authProvider.feature
        │   │   getTokenFake.feature
        │   │   getTokenFromJson.feature
        │   │   getTokenFromTxt.feature
        │   │
        │   └── posts
        │       getPosts.feature
        │
        ├── config
        │   credentials.json
        │   credentials.txt
        │
        ├── data
        │   auth
        │     loginRequest.json
        │
        ├── utils
        │   credentialLoader.js
        │   userSelector.js
        │
        └── karate-config.js
```

---

# Environment Configuration

The framework supports **multiple environments** using `karate.env`.

Example:

* dev
* qa
* prod

Configured in:

```
karate-config.js
```

Example execution:

Run DEV (default)

```
gradle test
```

Run QA

```
gradle test -Dkarate.env=qa
```

Run PROD

```
gradle test -Dkarate.env=prod
```

---

# karate-config.js

The configuration file performs the following tasks:

1. Detect environment
2. Set base URL
3. Configure authentication source
4. Generate global authentication token

Example configuration:

```javascript
function fn() {

  var env = karate.env;
  if (!env) {
    env = 'dev';
  }

  karate.log('Environment:', env);

  var config = {
    baseUrl: 'https://jsonplaceholder.typicode.com'
  };

  if (env == 'qa') {
    config.baseUrl = 'https://qa-api.mycompany.com';
  }

  if (env == 'prod') {
    config.baseUrl = 'https://api.mycompany.com';
  }

  config.authSource = 'fake';
  config.authUser = 'jperez';

  var auth = karate.callSingle('classpath:features/auth/authProvider.feature', {
      source: config.authSource,
      user: config.authUser
  });

  config.authToken = auth.authToken;

  karate.log('GLOBAL AUTH TOKEN:', config.authToken);

  return config;
}
```

The generated token becomes **globally available** in all features.

---

# Authentication Architecture

Authentication is centralized through:

```
authProvider.feature
```

This feature selects which authentication strategy to use.

Supported methods:

| Method | Description                 |
| ------ | --------------------------- |
| fake   | Generates random token      |
| json   | Reads credentials from JSON |
| txt    | Reads credentials from TXT  |

---

# AuthProvider Feature

```
features/auth/authProvider.feature
```

This feature dynamically selects the authentication strategy.

Example logic:

* fake → generate random token
* json → read credentials from JSON file
* txt → read credentials from TXT file

This pattern allows easy extension to additional auth types like:

* OAuth
* JWT
* API Keys

---

# Fake Authentication

Feature:

```
features/auth/getTokenFake.feature
```

Generates a random token for testing purposes.

Example:

```
fake-token-9a3c8d4c-1c9c-4f88-a6e7-9a6d1c3a8a23
```

This is useful for:

* local testing
* CI pipelines
* environments without authentication

---

# JSON Credentials Authentication

Credentials stored in:

```
config/credentials.json
```

Example:

```json
{
  "users": [
    {
      "username": "admin",
      "password": "password",
      "role": "ADMIN"
    },
    {
      "username": "jperez",
      "password": "12345",
      "role": "USER"
    }
  ]
}
```

User selection is performed using:

```
utils/userSelector.js
```

---

# TXT Credentials Authentication

Credentials stored in:

```
config/credentials.txt
```

Example:

```
username=admin
password=password

username=jperez
password=12345
```

Parsed using:

```
utils/credentialLoader.js
```

---

# Using Authentication in Features

Because the token is generated in `karate-config.js`, it is **available globally**.

Example feature:

```
Feature: Get posts

Scenario: Call API with token

Given url baseUrl + '/posts'
And header Authorization = 'Bearer ' + authToken
When method GET
Then status 200
```

No manual authentication calls are required.

---

# Logging Configuration

Karate supports detailed request and response logs.

Example:

```
* configure logPrettyRequest = true
* configure logPrettyResponse = true
```

This produces formatted logs in the console.

---

# JSON Schema Contract Validation

Karate supports contract validation using JSON schema.

Example:

```
And match response == read('classpath:models/postSchema.json')
```

Supported validators:

| Validator   | Meaning              |
| ----------- | -------------------- |
| #string     | value must be string |
| #number     | numeric value        |
| #boolean    | boolean              |
| #present    | field must exist     |
| #notpresent | field must not exist |

---

# Parallel Execution

Tests can run in parallel using Gradle configuration.

Example:

```
gradle test -Pthreads=3
```
If you prefer not to manually set the number of threads, you can allow the machine to automatically determine the optimal count based on the available CPU cores.
To enable this behavior, simply comment out the following line in the configuration file

```
def threads = project.findProperty("threads") ?: "1"
```

And uncomment out this one: 

```
def threads = project.findProperty("threads") ?: Runtime.runtime.availableProcessors()
```

Parallel execution improves performance for large test suites.

---

# Best Practices Implemented

The framework follows several automation best practices:

* Centralized authentication
* Externalized test data
* Environment configuration
* Reusable feature files
* Separation of logic and data
* Modular architecture
* Dynamic data handling
* Clean readable test scenarios

---

# Reporting

Karate automatically generates test reports.

Location:

```
build/karate-reports/
```

Main report:

```
karate-summary.html
```

Reports include:

* scenario execution results
* failures
* execution time
* feature statistics

---

# How to Run Tests

Run all tests

```
gradle test
```

Run specific environment

```
gradle test -Dkarate.env=qa
```

Run with parallel execution

```
gradle test -Pthreads=4
```

---

# Future Improvements

Planned improvements for the framework:

* OAuth authentication
* JWT validation
* Token refresh manager
* Performance testing integration
* Advanced reporting dashboards
* Test data factories
* Dynamic user generation
* Load testing scenarios

---

# Author

Karate_blackbelt is designed as an **advanced learning framework for QA Automation, SDET and Test Architecture practices using Karate DSL**.
