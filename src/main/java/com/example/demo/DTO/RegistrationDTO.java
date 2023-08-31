package com.example.demo.DTO;

import com.example.demo.model.User;
import lombok.Data;

@Data
public class RegistrationDTO {
     private User user;

     private String password;


}
