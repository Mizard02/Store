package com.example.demo.services;


import com.example.demo.model.OrderDetails;
import com.example.demo.repositories.OrderDetailsRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


@Service
public class OrderDetailsService {

    @Autowired
    OrderDetailsRepository odRepo;

    public void addToCart(OrderDetails od){
        odRepo.save(od);
    }

    public void removeFromCart(OrderDetails od){
        odRepo.delete(od);
    }

    public void removeAllFromCart(){
        odRepo.deleteAll();
    }

}
