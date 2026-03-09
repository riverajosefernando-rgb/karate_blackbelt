Feature: Generate dates

  @test1
  Scenario: Generate dates

    * def dateUtils = read('classpath:utils/dateUtils.js')

    * def timestamp = dateUtils.now()