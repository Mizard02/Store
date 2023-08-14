package com.example.demo.model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.util.Collection;
@Getter
@Setter
@EqualsAndHashCode
@ToString
@Entity
@Table(name="Product")
public class Product {

    @GeneratedValue
    @Id
    @Column(name="id", nullable = false)
    private long id;

    @Version
    @Column(name="version", nullable = false)
    private long version;

    @Basic
    @Column(name="name")
    private String name;

    @Basic
    @Column(name="price")
    private double price;

    @Basic
    @Column(name="quantity")
    private int quantity;

    @Basic
    @Column(name="barCode")
    private String barCode;

    @OneToMany(mappedBy = "product", cascade = CascadeType.MERGE, fetch = FetchType.EAGER )
    @JsonIgnore
    @ToString.Exclude
    private Collection<OrderDetails> orderDetails;

    @OneToMany( mappedBy = "product", cascade = CascadeType.MERGE, fetch = FetchType.EAGER )
    @JsonIgnore
    @ToString.Exclude
    private Collection<Review> reviews;
}
