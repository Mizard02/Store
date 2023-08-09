package entities;

import jakarta.persistence.Basic;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.Id;
import jakarta.persistence.ManyToOne;

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
}
