package com.example.demo.model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@Entity
@Table(name="OrderDetails")
public class OrderDetails {

    @GeneratedValue
    @Id
    @Column(name="id", nullable = false, unique = true)
    private long id;

    @Basic
    @Column(name="quantity")
    private int quantity;

    @Basic
    @Column(name="price")
    private double price;

    @ManyToOne(optional = false, cascade = CascadeType.MERGE)
    @JoinColumn(name = "product_id")
    private Product product;

    /*@ManyToOne
    @JoinColumn(name = "orders_id")
    private Order order;*/
}
