package com.postech.fiap.googlecloudfunctions;

import io.quarkus.funqy.Funq;
import jakarta.enterprise.context.ApplicationScoped;

import io.cloudevents.CloudEvent;

@ApplicationScoped
public class HelloWorldCloudEventsFunction {

    /**
     * Esta função agora é acionada pelo Funqy.
     * Para um evento do tipo CloudEvent, o nome da função é importante.
     * Usamos @Funq("HelloWorldCloudEventsFunction") para manter o nome original
     * e garantir que o gatilho do Google Cloud continue funcionando.
     * @param cloudEvent O payload do evento, que o Funqy mapeia automaticamente.
     */
    @Funq("HelloWorldCloudEventsFunction")
    public void onCloudEvent(CloudEvent cloudEvent) {
        System.out.println("Receive event Id: " + cloudEvent.getId());
        System.out.println("Receive event Subject: " + cloudEvent.getSubject());
        System.out.println("Receive event Type: " + cloudEvent.getType());
        System.out.println("Receive event Data: " + new String(cloudEvent.getData().toBytes()));
    }
}
