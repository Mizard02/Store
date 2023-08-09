package entities;

import jakarta.persistence.*;

public class Product {
    @GeneratedValue
    @Id
    private long id;
    @Version
    private long version;
    @Basic
    private String name;
    @Basic
    private double price;
    @Basic
    private Integer quantity;
    @ManyToOne(optional = false)
    private Category category;
}
