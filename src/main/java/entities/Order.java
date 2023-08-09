package entities;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;

import java.util.Collection;
import java.util.Date;
import java.util.LinkedList;

@Entity
public class Order {
    @GeneratedValue
    @Id
    private long id;
    @Basic
    private Date date;
    @ManyToOne(optional = false)
    @JsonIgnore
    private User client;
    @OneToMany(fetch = FetchType.EAGER)
    @JoinColumn(name = "order_id")
    private Collection<OrderDetails> details = new LinkedList<>();
}
