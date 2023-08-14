package com.example.demo.model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.util.Collection;
import java.util.Date;
import java.util.LinkedList;
@Getter
@Setter
@EqualsAndHashCode
@ToString
@Entity
@Table(name="Order,")
public class Order {

    @GeneratedValue
    @Id
    @Column(name = "id", nullable = false, unique = true)
    private long id;

    @Basic
    @Column(name = "time")
    private Date time;

    @ManyToOne(optional = false)
    @JoinColumn(name = "client")
    @JsonIgnore
    private User client;

    @OneToMany(fetch = FetchType.EAGER)
    @JoinColumn(name = "orderDetails")
    private Collection<OrderDetails> details = new LinkedList<>();
}
