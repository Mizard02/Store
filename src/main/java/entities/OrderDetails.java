package entities;

import jakarta.persistence.*;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@EqualsAndHashCode
@ToString
@Entity
@Table(name="OrderDetails")
public class OrderDetails {

    @GeneratedValue
    @Id
    @Column(name="id", nullable = false)
    private long id;

    @Basic
    @Column(name="quantity")
    private int quantity;

    @Basic
    @Column(name="price")
    private double price;

    @ManyToOne(optional = false, cascade = CascadeType.MERGE)
    @JoinColumn(name = "product")
    private Product product;

    @ManyToOne
    @JoinColumn(name = "orderDetails")
    private Order order;
}
