# 🥋 Karate Blackbelt – Advanced API Automation Framework

## Overview

**Karate_blackbelt** is an advanced **API automation testing framework** built using:

- Karate DSL
- Java 17
- Gradle
- JUnit 5

The project demonstrates **enterprise-level automation practices** including:

- Environment-based configuration
- Centralized authentication management
- Reusable features
- Externalized test data
- Dynamic data generation
- JSON schema contract validation
- Mock server simulation
- Error and latency testing
- Modular architecture

The goal of this framework is to simulate how **professional SDET / QA Automation frameworks** are designed in real projects.

---

# Technologies and Tools

| Technology | Purpose |
|---|---|
Java 17 | Runtime |
Karate DSL | API testing framework |
Gradle | Build and dependency management |
JUnit 5 | Test execution |
JSON | Test data format |
JavaScript | Utility functions and transformations |
Karate Mock Server | API simulation |
IntelliJ IDEA | Recommended IDE |
Git | Version control |

---

# Project Architecture

```
src
└── test
    ├── java
    │   └── runners
    │       TestRunner.java
    │
    │   └── runners.mock
    │       MockServerRunner.java
    │
    └── resources
        ├── features
        │   ├── auth
        │   │   authProvider.feature
        │   │   getTokenFake.feature
        │   │   getTokenFromJson.feature
        │   │   getTokenFromTxt.feature
        │   │
        │   ├── posts
        │   │   getPosts.feature
        │   │
        │   └── mock
        │       mockServer.feature
        │       deletePost.feature
        │       errorEndpoint.feature
        │       slowEndpoint.feature
        │       slowPerformance.feature
        │
        ├── config
        │   credentials.json
        │   credentials.txt
        │
        ├── data
        │   auth
        │     loginRequest.json
        │
        ├── models
        │   postSchema.json
        │
        ├── mock-data
        │   posts.json
        │
        ├── test-data
        │   responses
        │      mockResponses.json
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

Examples:

- dev
- qa
- prod
- mock

Configured in:

```
karate-config.js
```

Run default environment

```
gradle test
```

Run mock environment

```
gradle test -Dkarate.env=mock
```

---

# karate-config.js Responsibilities

The configuration file:

1. Detects the environment
2. Sets the base URL
3. Configures authentication source
4. Generates a global authentication token
5. Loads reusable test data

Example:

```javascript
function fn() {

  var env = karate.env;
  if (!env) {
    env = 'dev';
  }

  var config = {
    baseUrl: 'https://jsonplaceholder.typicode.com'
  };

  if (env == 'mock') {
    config.baseUrl = 'http://localhost:8080';
  }

  config.authSource = 'fake';
  config.authUser = 'jperez';

  var auth = karate.callSingle('classpath:features/auth/authProvider.feature', {
      source: config.authSource,
      user: config.authUser
  });

  config.authToken = auth.authToken;

  config.mockResponses = karate.read('classpath:test-data/responses/mockResponses.json');

  return config;
}
```

---

# Authentication Architecture

Authentication is centralized using:

```
authProvider.feature
```

Supported methods:

| Method | Description |
|---|---|
fake | Random token generation |
json | Credentials from JSON file |
txt | Credentials from TXT file |

This design allows easy extension to:

- OAuth
- JWT
- API Keys

---

# Externalized Test Data

Test data is separated from test logic.

Example file:

```
test-data/responses/mockResponses.json
```

Example:

```json
{
  "errorResponse": {
    "message": "Internal server error"
  },
  "slowResponse": {
    "message": "slow response"
  }
}
```

Usage in tests:

```
And match response == mockResponses.errorResponse
```

Benefits:

- Maintainability
- Reusability
- Easier API changes

---

# JSON Schema Contract Validation

API responses can be validated using schema models.

Example:

```
And match response == read('classpath:models/postSchema.json')
```

Example schema:

```json
{
  "id": "#number",
  "title": "#string",
  "body": "#string",
  "userId": "#number"
}
```

---

# Karate Mock Server

Karate can simulate full APIs without backend services.

Example endpoint:

```
GET /posts
```

Mock implementation:

```
Scenario: pathMatches('/posts') && methodIs('get')

* def response = posts
* def responseStatus = 200
```

---

# Mock CRUD Operations

The mock server supports:

| Method | Endpoint |
|---|---|
GET | /posts |
GET | /posts/{id} |
POST | /posts |
PUT | /posts/{id} |
DELETE | /posts/{id} |

Example delete logic:

```
* def index = posts.findIndex(function(x){ return x.id == id })

* eval
"""
if(index > -1){
   posts.splice(index,1);
}
"""

* def response =
"""
index > -1 ?
{ message: 'Post deleted successfully' } :
{ message: 'Post not found' }
"""

* def responseStatus = index > -1 ? 200 : 404
```

---

# Error Simulation

Mock endpoint:

```
GET /error
```

Response:

```json
{
  "message": "Internal server error"
}
```

Status:

```
500
```

Used to test:

- error handling
- retry logic
- resilience

---

# Latency Simulation

Mock endpoint:

```
GET /slow
```

Implementation:

```
* karate.pause(3000)
```

Used to simulate:

- slow services
- network latency
- timeout behavior

---

# Performance Validation

Example:

```
* assert responseTime >= 3000
```

Used to verify:

- API latency
- performance expectations

---

# Logging Configuration

Karate supports detailed logs.

```
* configure logPrettyRequest = true
* configure logPrettyResponse = true
```

---

# Parallel Execution

Run tests in parallel:

```
gradle test -Pthreads=3
```
If you prefer not to manually set the number of threads, you can allow the machine to automatically determine the optimal count based on the available CPU cores.
To enable this behavior, simply comment out the following line in the configuration file

```
def threads = project.findProperty("threads") ?: "1"
```

And uncomment out this one (Auto detect CPU cores): 

```
def threads = project.findProperty("threads") ?: Runtime.runtime.availableProcessors()
```

---

# Reporting

Karate automatically generates HTML reports.

Location:

```
build/karate-reports/
```

Main report:

```
karate-summary.html
```

Reports include:

- scenario execution results
- failures
- execution time
- request/response logs

---

# Best Practices Implemented

The framework applies the following automation best practices:

- Centralized authentication
- Externalized test data
- Environment-based configuration
- Mock server testing
- Reusable features
- Modular architecture
- Separation of test logic and test data
- Dynamic data handling
- Contract validation

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

**Karate_blackbelt** is designed as an **advanced learning framework for QA Automation, SDET and Test Architecture using Karate DSL**.