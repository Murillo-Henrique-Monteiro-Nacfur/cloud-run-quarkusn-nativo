package com.postech.fiap.googlecloudfunctions;

import io.quarkus.test.junit.QuarkusTest;
import org.junit.jupiter.api.Test;

import static io.restassured.RestAssured.given;
import static org.hamcrest.Matchers.is;

@QuarkusTest
class HelloWorldHttpFunctionTest {
    @Test
    void testHelloWorldHttpEndpoint() {
        // Com Funqy, a função é exposta em um endpoint com o mesmo nome do método.
        // Usamos 'given()' para ser explícito, embora 'when()' também funcione.
        given()
                .when()
                .post("/helloWorldHttp") // Funqy HTTP por padrão usa POST
                .then()
                .statusCode(200)
                .body(is("Hello World"));
    }
}
