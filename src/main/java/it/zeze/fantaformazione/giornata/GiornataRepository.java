package it.zeze.fantaformazione.giornata;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

@Repository
public interface GiornataRepository extends JpaRepository<Giornata, Long> {

    boolean existsGiornataByNumeroGiornataAndStagione(Integer numeroGiornata, String stagione);

    @Query("SELECT DISTINCT(stagione) FROM Giornata")
    Iterable<String> findAllStagione();
}
