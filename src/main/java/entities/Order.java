package entities;

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
@Table(name="Order")
public class Order {

    @GeneratedValue
    @Id
    @Column(name = "id", nullable = false)
    private long id;

    @Basic
    @Column(name = "date")
    private Date date;

    @ManyToOne(optional = false)
    @JoinColumn(name = "client")
    @JsonIgnore
    private User client;

    @OneToMany(fetch = FetchType.EAGER)
    @JoinColumn(name = "orderDetails")
    private Collection<OrderDetails> details = new LinkedList<>();
}
