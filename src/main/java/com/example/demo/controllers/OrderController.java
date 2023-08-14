package com.example.demo.controllers;

import com.example.demo.exceptions.*;
import com.example.demo.model.*;
import com.example.demo.services.OrderService;
import exceptions.UserNotExist;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.server.ResponseStatusException;

import java.util.List;

@RestController
@RequestMapping("/order")
public class OrderController {

    @Autowired
    private OrderService os;

    @PostMapping("/create")
    @ResponseStatus(code = HttpStatus.OK)
    public ResponseEntity create(@RequestBody @Valid Order o) { // è buona prassi ritornare l'oggetto inserito
        try {
            return new ResponseEntity<>(os.addOrder(o), HttpStatus.OK);
        } catch (QuantityProductUnavailableException e) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "Product quantity unavailable!", e); // realmente il messaggio dovrebbe essrere più esplicativo (es. specificare il prodotto di cui non vi è disponibilità)
        }
    }

    @GetMapping("/{user}")
    public List<Order> getOrders(@RequestBody @Valid User user) {
        try {
            return os.getOrdersByUser(user);
        } catch (UserNotExist e) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "User not found!", e);
        }
    }
}
