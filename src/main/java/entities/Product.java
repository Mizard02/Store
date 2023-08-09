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
    @Basic
    @Column(name = "bar_code", nullable = true)
    private String barCode;

    @Basic
    @Column(name = "description", nullable = true)
    private String description;
    @Basic
    @Column(name =" brand", nullable = false)
    private String brand;
}
