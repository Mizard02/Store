package com.example.demo.controllers;

import com.example.demo.DTO.OrderDTO;
import com.example.demo.exceptions.*;
import com.example.demo.model.*;
import com.example.demo.services.AccountingService;
import com.example.demo.services.OrderService;
import exceptions.UserNotExist;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.server.ResponseStatusException;

import java.util.ArrayList;
import java.util.List;

import static org.springframework.http.MediaType.APPLICATION_JSON_VALUE;

@RestController
@CrossOrigin("*")
@RequestMapping("/order")
public class OrderController {

    @Autowired
    private OrderService os;
    @Autowired
    private AccountingService us;

    @PostMapping(value = "/create", consumes = APPLICATION_JSON_VALUE)
    @ResponseStatus(code = HttpStatus.OK)
    public ResponseEntity create(@RequestBody @Valid OrderDTO o) { // è buona prassi ritornare l'oggetto inserito
        try {
            User u = us.getUser(o.getEmailUser());
            Order order = new Order(u, o.getDetails());

            return new ResponseEntity<>(os.addOrder(order), HttpStatus.OK);
        } catch (QuantityProductUnavailableException e) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "Product quantity unavailable!", e); // realmente il messaggio dovrebbe essrere più esplicativo (es. specificare il prodotto di cui non vi è disponibilità)
        } catch (UserNotExist e) {
            throw new RuntimeException(e);
        }
    }

    @GetMapping("/getOrders")
    public List<OrderDTO> getOrders(@RequestParam @Valid String email) {
        try {
            User u = us.getUser(email);
            List<Order> lo= os.getOrdersByUser(u);
            List<OrderDTO> orders= new ArrayList<>();
            ;
            for(int i=0;i<lo.size();i++) {
                orders.add(new OrderDTO(lo.get(i).getClient().getEmail(), lo.get(i).getOrderDetails().stream().toList()));
            }
            System.out.println(orders);
            return orders;
        } catch (UserNotExist e) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "User not found!", e);
        }
    }

}
