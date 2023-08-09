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
    @Basic
    @Column(name = "telephone_number", nullable = true, length = 20)
    private String telephoneNumber;

    @Basic
    @Column(name = "email", nullable = true, length = 90)
    private String email;

    @Basic
    @Column(name = "address", nullable = true, length = 150)
    private String address;

}
