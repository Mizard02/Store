package entities;

import jakarta.persistence.Basic;
import lombok.Data;

@Data
public class Jacket extends Product{

    @Basic
    private String Model;


}
