Feature: Generate multiple users

  Scenario: Generate n users

    * def users = []

    * def generator = read('classpath:utils/dataGenerator.js')

    * eval
"""
for(var i=0;i<100;i++){

 users.push(generator.generateUser())

}
"""

    * print 'Users generated:', users