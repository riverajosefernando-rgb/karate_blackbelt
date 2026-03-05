Feature: Generate transactions

  Scenario: Generate n transacctios

    * def transactions = []

    * eval
"""
for(var i=0;i<1000;i++){

 transactions.push({

   id: java.util.UUID.randomUUID() + '',
   amount: Math.random() * 1000,
   timestamp: new Date().getTime()

 })

}
"""

    * print 'Transactions generated:', transactions.length