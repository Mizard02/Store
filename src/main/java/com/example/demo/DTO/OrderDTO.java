package com.example.demo.DTO;

import com.example.demo.model.OrderDetails;
import lombok.Data;

import java.util.List;
@Data
public class OrderDTO {
    private String emailUser;

    private List<OrderDetails> details;
}
