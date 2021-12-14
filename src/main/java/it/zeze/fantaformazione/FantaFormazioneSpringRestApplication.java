package it.zeze.fantaformazione;

import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;

@SpringBootApplication
@Slf4j
public class FantaFormazioneSpringRestApplication {

    public static void main(String[] args) {
        SpringApplication.run(FantaFormazioneSpringRestApplication.class, args);
    }

    @Bean
    CommandLineRunner runner() {
        return args -> {
            log.debug("--- STARTED ---");
        };
    }

}
