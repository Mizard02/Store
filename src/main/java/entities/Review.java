package entities;

import jakarta.persistence.Basic;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.Id;
import jakarta.persistence.ManyToOne;
import lombok.Data;

import java.util.Date;

@Data
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
