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
    public ResponseEntity create(@RequestBody @Valid Jacket product) { //ho tolto l'annotazione valid =>vedere come riaggiungerla
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
            // Converte la lista in una rappresentazione JSON
            String jsonResult = objectMapper.writeValueAsString(result);
            return new ResponseEntity<>(jsonResult, HttpStatus.OK);
        } catch (JsonProcessingException e) {
            return null;
        }
    }


    @GetMapping("/paged")
    public ResponseEntity getAll(@RequestParam(value = "pageNumber", defaultValue = "0") int pageNumber, @RequestParam(value = "pageSize", defaultValue = "10") int pageSize, @RequestParam(value = "sortBy", defaultValue = "id") String sortBy) {
        List<Product> result = productService.showAllProducts(pageNumber, pageSize, sortBy);
        if ( result.size() <= 0 ) {
            return new ResponseEntity<>(new ResponseMessage("No results!"), HttpStatus.OK);
        }
        return new ResponseEntity<>(result, HttpStatus.OK);
    }

    @GetMapping("/search/by_name")
    public ResponseEntity getByName(@RequestParam(required = false) String name) {
        List<Product> result = productService.showProductsByName(name);
        if ( result.size() <= 0 ) {
            return new ResponseEntity<>(new ResponseMessage("No results!"), HttpStatus.OK);
        }
        return new ResponseEntity<>(result, HttpStatus.OK);
    }

    @DeleteMapping(value = "/deleteAllProducts")
    //@PreAuthorize("hasRole('admin')")
    public void deleteAll() {
        productService.deleteAllProducts();
    }


}
