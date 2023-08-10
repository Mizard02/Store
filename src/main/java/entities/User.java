package entities;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;

import java.util.Collection;
import java.util.LinkedList;

@Entity
public class User {
    @GeneratedValue
    @Id
    private long id;
    @Basic
    private String surname;

    @Basic
    private String name;

    @Basic
    private String indirizzo;
    @Basic
    private String telefono;

    @OneToMany(mappedBy = "client")
    @JsonIgnore
    private Collection<Order> orders;

    @OneToMany
    @JsonIgnore
    private LinkedList<Review> reviews;
}
