package com.example.demo.controllers;

import com.example.demo.exceptions.QuantityProductUnavailableException;
import com.example.demo.model.OrderDetails;
import com.example.demo.model.User;
import com.example.demo.services.OrderDetailsService;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import static org.springframework.http.MediaType.APPLICATION_JSON_VALUE;

@RestController
@RequestMapping("/orderDetails")
public class OrderDetailsController {
    @Autowired
    private OrderDetailsService os;

    @PostMapping(value = "/create", consumes = APPLICATION_JSON_VALUE)
    @ResponseStatus(code = HttpStatus.OK)
    public ResponseEntity create(@RequestBody OrderDetails o) {
            os.addToCart(o);
            ResponseEntity responseEntity = new ResponseEntity<>(null, HttpStatus.OK);
            return responseEntity;
    }

    @DeleteMapping(value="/deleteOrderDetails", consumes =APPLICATION_JSON_VALUE )
    @ResponseStatus(code = HttpStatus.OK)
    public ResponseEntity delete(@RequestBody OrderDetails o) {
        os.removeFromCart(o);
        ResponseEntity responseEntity = new ResponseEntity<>(null, HttpStatus.OK);
        return responseEntity;
    }
    @DeleteMapping(value="/deleteAllOrderDetails", consumes =APPLICATION_JSON_VALUE )
    @ResponseStatus(code = HttpStatus.OK)
    public ResponseEntity deleteAll() {
        os.removeAllFromCart();
        ResponseEntity responseEntity = new ResponseEntity<>(null, HttpStatus.OK);
        return responseEntity;
    }

}
