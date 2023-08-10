package entities;

import jakarta.persistence.*;
import lombok.*;

import java.util.Date;
@Getter
@Setter
@EqualsAndHashCode
@ToString
@Entity
public class Review {
    @GeneratedValue
    @Id
    private long id;

    @Basic
    private String testo;

    @Basic
    private Date date;

    @ManyToOne(optional = false)
    private User client;

    @ManyToOne(optional = false)
    private Product product;
}
