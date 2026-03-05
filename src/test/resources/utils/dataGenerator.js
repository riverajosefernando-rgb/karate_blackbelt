function generateUser(){

  return {
     id: java.util.UUID.randomUUID() + '',
     name: 'user-' + new Date().getTime(),
     timestamp: new Date().getTime()
  };

}