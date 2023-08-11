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
    @Column(name="id", nullable = false)
    private long id;

    @Basic
    @Column(name="text")
    private String text;

    @Basic
    @Column(name="date")
    private Date date;

    @ManyToOne(optional = false)
    private User client;

    @ManyToOne(optional = false, cascade = CascadeType.MERGE)
    @JoinColumn(name = "review")
    private Product product;
    /*
    l'annotazione @OneToMany con questi parametri sta definendo una relazione uno-a-molti tra l'entità in cui è applicata e l'entità Product.
    Ogni oggetto di questa entità potrà avere una collezione di oggetti Review,
    e quando viene eseguita un'operazione di merge sull'oggetto principale, l'operazione verrà propagata anche agli oggetti correlati Product (se presenti).
     */
}
