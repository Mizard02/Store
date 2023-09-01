package com.example.demo.model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;
import lombok.*;

import java.util.Collection;

@Getter
@Setter
@EqualsAndHashCode
@ToString
@Entity
@Table(name="users")
public class User {
    public User(String surname, String name, String email, String address, String phoneNumber) {
        this.surname = surname;
        this.name = name;
        this.email = email;
        this.address = address;
        this.phoneNumber = phoneNumber;
    }

    @GeneratedValue
    @Id
    @Column(name="id", nullable = false, unique = true)
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
    @Column(name="address")
    private String address;

    @Basic
    @Column(name="phoneNumber")
    private String phoneNumber;

    @OneToMany(mappedBy = "client",  cascade = CascadeType.MERGE, fetch = FetchType.EAGER)
    @JsonIgnore
    private Collection<Order> orders;

    @OneToMany(mappedBy = "client")
    @JsonIgnore
    private Collection<Review> reviews;

    public User() {
    }
}
