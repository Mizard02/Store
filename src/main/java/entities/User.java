package entities;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.util.Collection;
import java.util.LinkedList;
@Getter
@Setter
@EqualsAndHashCode
@ToString
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
    private String email;
    @Basic
    private String phoneNumber;

    @OneToMany(mappedBy = "client")
    @JsonIgnore
    private Collection<Order> orders;

    @OneToMany
    @JsonIgnore
    private LinkedList<Review> reviews;
}
