@regression
Feature: Automatizar feature store de API PetStore

  Background:
    * url apiPetStore
    * def storeClient = read('classpath:examples/store/store.feature')

  @TEST-01
  @happyPath
  Scenario: Consultar inventario de mascotas por estado

    Given path 'store/inventory'
    When method get
    Then status 200
    * print response

  @TEST-02
  @happyPath
  Scenario Outline: Crear un pedido para mascota

    * def order = read(<json_path>)
    * def orderId = order.id

    Given path 'store/order'
    And request order
    When method post
    Then status 200
    And match response.id == orderId
    * print response

    Examples:
      | json_path                                                    |
      | 'classpath:resources/examples/data/store/store-order.json'   |
      | 'classpath:resources/examples/data/store/store-order-2.json' |

  @TEST-03
  @happyPath
  Scenario Outline: Buscar orden de compra por id

    * def order = read(<json_path>)
    * def orderId = order.id

    Given path 'store/order', orderId
    When method get
    Then status 200
    And match response.id == orderId
    * print 'GET orderId:', orderId
    * print 'GET response:', response

    Examples:
      | json_path                                                    |
      | 'classpath:resources/examples/data/store/store-order.json'   |
      | 'classpath:resources/examples/data/store/store-order-2.json' |

  @TEST-04
  @happyPath
  Scenario Outline: Eliminar orden por id

    * def order = read(<json_path>)
    * def orderId = order.id

    Given path 'store/order', orderId
    When method delete
    Then status 200
    And match response.message == '' + orderId
    * print response

    Examples:
      | json_path                                                    |
      | 'classpath:resources/examples/data/store/store-order.json'   |
      | 'classpath:resources/examples/data/store/store-order-2.json' |

  @TEST-05
  @unhappyPath
  Scenario Outline: Buscar orden eliminada con ID

    * def order = read(<json_path>)
    * def orderId = order.id

    Given path 'store/order', orderId
    When method get
    Then status 404
    And match response.code == 1
    And match response.message == 'Order not found'
    * print response

    Examples:
      | json_path                                                    |
      | 'classpath:resources/examples/data/store/store-order.json'   |
      | 'classpath:resources/examples/data/store/store-order-2.json' |

  @TEST-06
  @unhappyPath
  Scenario Outline: Buscar orden con ID inválido (fuera de rango - mayor a 10)
    * def orderId = <orderId>
    Given path 'store/order', orderId
    When method get
    Then status 404
    * print response

    Examples:
      | orderId |
      | 11      |
      | -1      |
      | 999     |

  @TEST-07
  @unhappyPath
  Scenario: Crear orden sin body

    Given path 'store/order'
    And request {}
    When method post
    Then status 200
    And match response == '#object'

    * print 'NO DEBERÍA ACEPTAR BODY VACÍO'
    * print response

  @TEST-08
  @unhappyPath
  Scenario Outline: Crear orden con un solo atributo

    Given path 'store/order'
    And request <payload>
    When method post
    Then status 200
    And match response == '#object'

    * print 'endpoints store/order acepta payload incompleto'
    * print response

    Examples:
      | payload                                  |
      | { id: 7 }                                |
      | { petId: 89 }                            |
      | { quantity: 99 }                         |
      | { shipDate: '2026-11-20T21:00:00.000Z' } |
      | { status: 'placed' }                     |
      | { status: true }                         |