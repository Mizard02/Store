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
@Table(name="User")
public class User {
    @GeneratedValue
    @Id
    @Column(name="id", nullable = false)
    private long id;

    @Basic
    @Column(name="surname")
    private String surname;

    @Basic
    @Column(name="name")
    private String name;

    @Basic
    @Column(name="email")
    private String email;

    @Basic
    @Column(name="phoneNumber")
    private String phoneNumber;

    @OneToMany(mappedBy = "client",  cascade = CascadeType.MERGE)
    @JsonIgnore
    private Collection<Order> orders;

    @OneToMany(mappedBy = "review")
    @JsonIgnore
    private LinkedList<Review> reviews;

}
