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
public class OrderDetails {
    @GeneratedValue
    @Id
    private long id;
    @Basic
    private int quantity;
    @Basic
    private double price;
    @ManyToOne(optional = false)
    private Product product;

    @ManyToOne
    private Order order;
}
