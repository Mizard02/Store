package entities;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;

import java.util.Collection;

@Entity
public class User {
    @GeneratedValue
    @Id
    private long id;
    @Basic
    private String surname;

    @Basic
    private String name;

    @OneToMany(mappedBy = "client")
    @JsonIgnore
    private Collection<Order> orders;
}
