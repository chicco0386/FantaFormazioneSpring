package it.zeze.fantaformazione.giornata;

import lombok.extern.log4j.Log4j2;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/rest/v1/giornata")
@Log4j2
public class GiornataRestController {

    @Autowired
    GiornataService giornataService;

    @GetMapping(produces = MediaType.APPLICATION_JSON_VALUE)
    public Iterable<Giornata> getAll() {
        return giornataService.getAll();
    }

    @GetMapping(path = "/stagioni", produces = MediaType.APPLICATION_JSON_VALUE)
    public Iterable<String> getStagioni() {
        return giornataService.findAllStagione();
    }

    @PostMapping(produces = MediaType.APPLICATION_JSON_VALUE)
    public Giornata insert(@RequestBody Giornata toInsert) {
        return giornataService.insert(toInsert);
    }

}
