package com.example.demo.controllers;



import com.example.demo.model.User;
import com.example.demo.services.AccountingService;
import exceptions.MailUserAlreadyExistsException;
import exceptions.ResponseMessage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;


import java.util.List;

@RestController
@RequestMapping("/users")
public class UsersController {
    @Autowired
    private AccountingService accountingService;

    @PostMapping("/create")
    public ResponseEntity create(@RequestBody User user) {
        try {
            User added = accountingService.registerUser(user);
            return new ResponseEntity(added, HttpStatus.OK);
        } catch (MailUserAlreadyExistsException e) {
            return new ResponseEntity<>(new ResponseMessage("ERROR_MAIL_USER_ALREADY_EXISTS"), HttpStatus.BAD_REQUEST);
        }
    }

    @GetMapping("/getAllUsers")
    public List<User> getAll() {
        return accountingService.getAllUsers();
    }

    @DeleteMapping("/deleteAllUsers")
    public void deleteAll() {
        accountingService.deleteAllUsers();
    }

    @DeleteMapping("/deleteById")
    public void deleteById(@RequestBody int id){
        accountingService.deleteById(id);
    }

}
