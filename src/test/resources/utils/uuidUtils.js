function fn(){

  function generateUUID(){
      return java.util.UUID.randomUUID() + '';
  }

  return {
      generateUUID: generateUUID
  }

}