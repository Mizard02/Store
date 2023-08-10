package entities;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;

import java.util.LinkedList;

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

    @OneToMany
    @JsonIgnore
    private LinkedList<Review> reviews;
}
