Feature: Generate uuids

  Scenario: Generate uuids

    * def uuidUtils = call read('classpath:utils/uuidUtils.js')

    * def id = uuidUtils.generateUUID()

    * print id