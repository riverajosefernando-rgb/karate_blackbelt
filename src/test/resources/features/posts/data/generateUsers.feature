Feature: Generate multiple users

  Scenario: Generate n users

    * def generator = call read('classpath:utils/dataGenerator.js')

    * def users = karate.repeat(10, function(){ return generator.generateUser() })

    * print 'Users generated:', users