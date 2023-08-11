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
@Table(name="Jacket")
@Inheritance(strategy = InheritanceType.JOINED)
public class Jacket extends Product{

    @Basic
    @Column(name="model")
    private String model;

    @Basic
    @Column(name="size")
    private Size size;
}
