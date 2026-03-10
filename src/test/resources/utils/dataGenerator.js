function fn() {

  function generateUser(){

    return {
       id: java.util.UUID.randomUUID() + '',
       name: 'user-' + new Date().getTime(),
       timestamp: new Date().getTime()
    };

  }

  return {
    generateUser: generateUser,

//    generatePost: generatePost,

//    generateTransaction: generateTransaction
  };

}