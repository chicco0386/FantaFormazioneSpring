package it.zeze.fantaformazione.giornata;

import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.*;

import javax.persistence.*;
import javax.validation.constraints.Pattern;
import java.time.LocalDate;

// Lombok
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
// Persistence
@Entity
@Table(name = "giornate")
public class Giornata {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @JsonIgnore
    private Long id;
    private Integer numeroGiornata;
    @Pattern(regexp = "^(\\d){4}\\/(\\d){2}")
    private String stagione;
    @Column(name = "data", columnDefinition = "DATE")
    private LocalDate data;

}
