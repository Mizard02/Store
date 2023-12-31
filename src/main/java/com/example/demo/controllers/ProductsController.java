package com.example.demo.controllers;



import com.example.demo.model.Jacket;
import com.example.demo.model.Product;
import com.example.demo.services.ProductService;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import exceptions.BarCodeAlreadyExistException;
import exceptions.ResponseMessage;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.*;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;


import java.util.List;

import static org.springframework.http.MediaType.APPLICATION_JSON_VALUE;

@Controller
@CrossOrigin("*")
@RequestMapping("/products")
public class ProductsController {
    @Autowired
    private ProductService productService;


    @PostMapping(value = "/create", consumes = APPLICATION_JSON_VALUE)
    public ResponseEntity create(@RequestBody @Valid Jacket product) {
        try {
            productService.addProduct(product);
        } catch (BarCodeAlreadyExistException e) {
            return new ResponseEntity<>(new ResponseMessage("Barcode already exist!"), HttpStatus.BAD_REQUEST);
        }
        return new ResponseEntity<>(new ResponseMessage("Added successful!"), HttpStatus.OK);
    }

    @GetMapping("/getAll")
    public ResponseEntity<String> getAll() {
        List<Product> result = productService.showAllProducts();
        ObjectMapper objectMapper = new ObjectMapper();
        try {

            String jsonResult = objectMapper.writeValueAsString(result);
            return new ResponseEntity<>(jsonResult, HttpStatus.OK);
        } catch (JsonProcessingException e) {
            return null;
        }
    }



    @GetMapping("/search/by_name")
    public ResponseEntity<String> productGetByName(@RequestParam String name) {
        List<Product> result = productService.showProductsByName(name);
        System.out.println(result.get(0));
        ObjectMapper objectMapper = new ObjectMapper();
        try {

            String jsonResult = objectMapper.writeValueAsString(result.get(0));
            return new ResponseEntity<>(jsonResult, HttpStatus.OK);
        } catch (JsonProcessingException e) {
            return null;
        }
    }
    @DeleteMapping(value = "/deleteAllProducts")
    public void deleteAll() {
        productService.deleteAllProducts();
    }


}
