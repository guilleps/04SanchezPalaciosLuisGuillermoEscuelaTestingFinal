@regression
Feature: Automatizar feature user de API PetStore

  Background:
    * url apiPetStore

  @TEST-01
  @happyPath
  Scenario Outline: Crear usuario

    * def user = read(<json_path>)
    * def username = user.username

    Given path 'user'
    And request user
    When method post
    Then status 200
    * print 'Usuario creado:', username

    Examples:
      | json_path                                            |
      | 'classpath:resources/examples/data/user/user-1.json' |
      | 'classpath:resources/examples/data/user/user-2.json' |


  @TEST-02
  @happyPath
  Scenario Outline: Buscar usuario por username

    * def user = read(<json_path>)
    * def username = user.username

    Given path 'user', username
    When method get
    Then status 200
    And match response.username == username
    * print 'Usuario encontrado:', response

    Examples:
      | json_path                                            |
      | 'classpath:resources/examples/data/user/user-1.json' |
      | 'classpath:resources/examples/data/user/user-2.json' |


  @TEST-03
  @happyPath
  Scenario Outline: Actualizar usuario

    * def user = read(<json_path>)
    * def username = user.username
    * set user.firstName = 'UpdatedName'

    Given path 'user', username
    And request user
    When method put
    Then status 200
    * print 'Usuario actualizado:', username

    Examples:
      | json_path                                            |
      | 'classpath:resources/examples/data/user/user-1.json' |


  @TEST-04
  @happyPath
  Scenario Outline: Eliminar usuario

    * def user = read(<json_path>)
    * def username = user.username

    Given path 'user', username
    When method delete
    Then status 200
    * print 'Usuario eliminado:', username

    Examples:
      | json_path                                            |
      | 'classpath:resources/examples/data/user/user-1.json' |
      | 'classpath:resources/examples/data/user/user-2.json' |

  @TEST-05
  @unhappyPath
  Scenario: Buscar usuario inexistente

    * def username = 'usuarioInexistenteQA'

    Given path 'user', username
    When method get
    Then status 404
    And match response.message == 'User not found'
    * print response


  @TEST-06
  @unhappyPath
  Scenario: Crear usuario sin body

    Given path 'user'
    And request {}
    When method post
    Then status 200

    * print 'HALLAZGO: Endpoint acepta usuario sin atributos'
    * print response


  @TEST-07
  @unhappyPath
  Scenario Outline: Login con credenciales inválidas (Error en validaciones de regla de negocio)

    Given path 'user', 'login'
    And param username = <username>
    And param password = <password>
    When method get
    Then status 200

    * print 'DEBERIA RETORNAR STATUS: 401 CREDENCIALES INVÁLIDAS'
    * print response

    Examples:
      | username    | password        |
      | 'wrongUser' | 'wrongPass'     |
      | 'user1'     | 'incorrectPass' |


  @TEST-08
  @unhappyPath
  Scenario: Eliminar usuario inexistente

    * def username = 'usuarioNoExiste'

    Given path 'user', username
    When method delete
    Then status 404
    * print response