Feature: Create post with transformed data
  @test
  Scenario Outline: Create post advance

    Given url baseUrl + '/posts'
    And request { title: <title>, body: <body>, userId: <userId>, timestamp: <timestamp> }
    When method POST
    Then status 201

    Examples:
      | karate.map(read('classpath:data/postData.json'), read('classpath:utils/dataTransformer.js')) |