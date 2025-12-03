package com.postech.fiap.googlecloudfunctions;

import io.quarkus.funqy.Funq;
import jakarta.enterprise.context.ApplicationScoped;

// A anotação @Named e a implementação da interface foram removidas.
@ApplicationScoped
public class HelloWorldBackgroundFunction {

    /**
     * Esta função agora é acionada pelo Funqy.
     * Para um evento de Cloud Storage, o nome da função é importante.
     * Usamos @Funq("HelloWorldBackgroundFunction") para manter o nome original
     * e garantir que o gatilho do Google Cloud continue funcionando.
     * @param event O payload do evento, que o Funqy mapeia automaticamente.
     */
    @Funq("HelloWorldBackgroundFunction")
    public void onStorageEvent(StorageEvent event) {
        System.out.println("Receive event on file: " + event.name);
    }

    // A classe interna para o payload do evento permanece a mesma.
    public static class StorageEvent {
        public String name;
    }
}
