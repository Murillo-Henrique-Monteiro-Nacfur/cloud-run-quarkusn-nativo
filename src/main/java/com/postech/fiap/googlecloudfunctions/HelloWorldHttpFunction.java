package com.postech.fiap.googlecloudfunctions;

import io.quarkus.funqy.Funq;
import jakarta.enterprise.context.ApplicationScoped;

@ApplicationScoped
public class HelloWorldHttpFunction {

    /**
     * Com Funqy, uma função HTTP simples pode apenas retornar o corpo da resposta.
     * O Funqy cuida da criação da resposta HTTP.
     * O nome da função se torna o path do endpoint, ex: /helloWorldHttp
     */
    @Funq
    public String helloWorldHttp() {
        return "Hello World";
    }
}
