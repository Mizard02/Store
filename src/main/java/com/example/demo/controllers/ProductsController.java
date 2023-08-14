package com.example.demo.controllers;



import com.example.demo.model.Product;
import com.example.demo.services.ProductService;
import exceptions.BarCodeAlreadyExistException;
import exceptions.ResponseMessage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.*;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;


import java.util.List;

import static org.springframework.http.MediaType.APPLICATION_JSON_VALUE;

@Controller
@RequestMapping("/products")
public class ProductsController {
    @Autowired
    private ProductService productService;


    @PostMapping(value = "/create", consumes = APPLICATION_JSON_VALUE)
    public ResponseEntity create(@RequestBody Product product) { //ho tolto l'annotazione valid =>vedere come riaggiungerla
        try {
            productService.addProduct(product);
        } catch (BarCodeAlreadyExistException e) {
            return new ResponseEntity<>(new ResponseMessage("Barcode already exist!"), HttpStatus.BAD_REQUEST);
        }
        return new ResponseEntity<>(new ResponseMessage("Added successful!"), HttpStatus.OK);
    }

    @GetMapping("/getAll")
    public List<Product> getAll() {
        return productService.showAllProducts();
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


}
