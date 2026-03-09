Feature: Generate dynamic test data

  @test
  Scenario: Generate random data

    * def dataUtils = call read('classpath:utils/dataUtils.js')

    * def id = dataUtils.uuid()
    * def email = dataUtils.randomEmail()
    * def name = dataUtils.randomName()
    * def phone = dataUtils.randomNumber(10)
    * def today = dataUtils.today()
    * def future = dataUtils.futureDate(5)

    * print 'UUID:', id
    * print 'Email:', email
    * print 'Name:', name
    * print 'Phone:', phone
    * print 'Today:', today
    * print 'Future date:', future