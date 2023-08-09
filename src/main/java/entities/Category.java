package entities;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.Basic;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;

import java.util.Collection;
import java.util.LinkedList;

public class Category {
    @GeneratedValue
    @Id
    private long id;
    @Basic
    private String name;
    @OneToMany(mappedBy = "categoria")
    @JsonIgnore
    private Collection<Product> products = new LinkedList<>();
}
