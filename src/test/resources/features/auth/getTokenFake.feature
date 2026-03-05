Feature: Get authentication token fake

  Scenario: Generate fake token

    * def authToken = 'fake-token-' + java.util.UUID.randomUUID()

    * print 'Generated token:', authToken