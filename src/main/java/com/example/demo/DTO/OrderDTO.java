package com.example.demo.DTO;

import com.example.demo.model.OrderDetails;
import lombok.Data;
import java.util.List;

@Data
public class OrderDTO {
    private String emailUser;
    private List<OrderDetails> details;

    public OrderDTO(){

    }
    public OrderDTO(String emailUser, List<OrderDetails> details) {
        this.emailUser = emailUser;
        this.details = details;
    }
}
