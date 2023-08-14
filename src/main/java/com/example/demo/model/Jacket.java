package com.example.demo.model;

import jakarta.persistence.*;
import lombok.*;

@Getter
@Setter
@EqualsAndHashCode
@ToString
@Entity
//@Table(name="Jacket")
@Inheritance(strategy = InheritanceType.JOINED)
public class Jacket extends Product{

    @Basic
    @Column(name="model")
    private String model;

    @Basic
    @Column(name="size")
    private Size size;
}
