package entities;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.util.LinkedList;
@Getter
@Setter
@EqualsAndHashCode
@ToString
@Entity
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
    private String barCode;

    @OneToMany
    @JsonIgnore
    private LinkedList<Review> reviews;
}
