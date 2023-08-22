package com.example.demo.controllers;



import com.example.demo.model.User;
import com.example.demo.services.AccountingService;
import exceptions.MailUserAlreadyExistsException;
import exceptions.ResponseMessage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;


import java.util.List;

import static org.springframework.http.MediaType.APPLICATION_JSON_VALUE;

@RestController
@RequestMapping("/users")
public class UsersController {
    @Autowired
    private AccountingService accountingService;

    @PostMapping(value = "/create", consumes = APPLICATION_JSON_VALUE)
    public ResponseEntity create(@RequestBody User user) {
        try {
            User added = accountingService.registerUser(user);
            return new ResponseEntity(added, HttpStatus.OK);
        } catch (MailUserAlreadyExistsException e) {
            return new ResponseEntity<>(new ResponseMessage("ERROR_MAIL_USER_ALREADY_EXISTS"), HttpStatus.BAD_REQUEST);
        }
    }

    @GetMapping("/getAllUsers")
    @PreAuthorize("hasRole('admin')")
    public List<User> getAll() {
        return accountingService.getAllUsers();
    }

    @DeleteMapping(value = "/deleteAllUsers", consumes = APPLICATION_JSON_VALUE)
    public void deleteAll() {
        accountingService.deleteAllUsers();
    }

    @DeleteMapping(value = "/deleteById", consumes = APPLICATION_JSON_VALUE)
    @PreAuthorize("hasRole('admin super')")
    public ResponseEntity deleteById(@RequestParam int id){
        accountingService.deleteById(id);
        return ResponseEntity.ok("User with ID " + id + " has been deleted");
    }

}
