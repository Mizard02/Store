package com.example.demo.model;

import jakarta.persistence.*;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import org.hibernate.annotations.CreationTimestamp;

import java.util.Collection;
import java.util.Date;

@Setter
@Getter
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
    @CreationTimestamp
    @Temporal(TemporalType.TIMESTAMP)
    private Date time;

    @ManyToOne(optional = false)
    @JoinColumn(name = "client")
    private User client;

    @OneToMany(fetch = FetchType.EAGER)
    @JoinColumn(name = "orderDetails")
    private Collection<OrderDetails> orderDetails;



    public double getTotalPrice(){
        double res = 0;
        for(OrderDetails od: orderDetails)
            res += od.getPrice();
        return res;
    }
}
