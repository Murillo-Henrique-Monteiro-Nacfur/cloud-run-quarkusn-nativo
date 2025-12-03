package com.postech.fiap.googlecloudfunctions;

import io.quarkus.test.junit.QuarkusTest;
import jakarta.inject.Inject;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertDoesNotThrow;

@QuarkusTest
class HelloWorldBackgroundFunctionTest {

    @Inject
    HelloWorldBackgroundFunction function; // Injeta a função diretamente

    @Test
    void testOnStorageEvent() {
        // 1. Prepara o evento de entrada
        HelloWorldBackgroundFunction.StorageEvent event = new HelloWorldBackgroundFunction.StorageEvent();
        event.name = "hello.txt";

        // 2. Chama o método diretamente
        // 3. Verifica se nenhuma exceção é lançada
        assertDoesNotThrow(() -> function.onStorageEvent(event));

        // Em um cenário real, você poderia usar Mockito para verificar
        // se um serviço injetado na função foi chamado corretamente.
    }
}
