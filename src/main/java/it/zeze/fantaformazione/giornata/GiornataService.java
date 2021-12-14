package it.zeze.fantaformazione.giornata;

import lombok.extern.log4j.Log4j2;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.validation.Valid;

@Service
@Log4j2
public class GiornataService {

    @Autowired
    private GiornataRepository giornataRepository;

    public Iterable<Giornata> getAll() {
        return giornataRepository.findAll();
    }

    public Iterable<String> findAllStagione() {
        return giornataRepository.findAllStagione();
    }


    public Giornata insert(@Valid Giornata toInsert) {
        Giornata toReturn = null;
        boolean exist = giornataRepository.existsGiornataByNumeroGiornataAndStagione(toInsert.getNumeroGiornata(), toInsert.getStagione());
        if (!exist) {
            toReturn = giornataRepository.save(toInsert);
        } else {
            log.info("Giornata [" + toInsert + "] already present into DB");
        }
        return toReturn;
    }
}
