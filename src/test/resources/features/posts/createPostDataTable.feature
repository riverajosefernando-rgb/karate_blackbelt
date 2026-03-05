Feature: Create post with transformed data

  @smoke
  Scenario Outline: Create post advance with datatable with print

    Given url baseUrl + '/posts'

    * def payload =
    """
    {
      title: <title>,
      body: <body>,
      userId: <userId>,
      timestamp: <timestamp>
    }
    """

    * print 'REQUEST:', payload

    And request payload
    When method POST

    * print 'RESPONSE:', response

    Then status 201

    Examples:
      | title | body  | userId | timestamp |
      | test1 | body1 | 1      | 123       |