package com.example.demo.controllers;



import com.example.demo.configurations.KeycloakCommand;
import com.example.demo.model.User;
import com.example.demo.services.AccountingService;
import exceptions.MailUserAlreadyExistsException;
import exceptions.ResponseMessage;
import exceptions.UserNotExist;
import jakarta.persistence.EntityManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;
import com.example.demo.DTO.RegistrationDTO;


import java.util.List;

import static org.springframework.http.MediaType.APPLICATION_JSON_VALUE;

@RestController
@CrossOrigin("*")
@RequestMapping("/users")
public class UsersController {
    @Autowired
    private AccountingService accountingService;

    @Autowired
    private EntityManager EM;

    @PostMapping(value = "/create", consumes = APPLICATION_JSON_VALUE)
    public ResponseEntity create(@RequestBody RegistrationDTO dati) {
        try {
            User added = accountingService.registerUser(dati.getUser());
            KeycloakCommand.AddUser(dati.getUser(), dati.getPassword());
            return new ResponseEntity(added, HttpStatus.OK);
        } catch (MailUserAlreadyExistsException e) {
            return new ResponseEntity<>(new ResponseMessage("ERROR_MAIL_USER_ALREADY_EXISTS"), HttpStatus.BAD_REQUEST);
        }
    }
    @GetMapping("getUser")
    public User getUser(@RequestParam String email){
        try {
            System.out.println("getUser");
            return accountingService.getUser(email);
        } catch (UserNotExist e) {
            throw new RuntimeException(e);
        }
    }
    @GetMapping("/getAllUsers")
    //@PreAuthorize("hasRole('user')")
    public List<User> getAll() {
        return accountingService.getAllUsers();
    }

    @DeleteMapping(value = "/deleteAllUsers")
    //@PreAuthorize("hasRole('admin')")
    public void deleteAll() {
        accountingService.deleteAllUsers();
    }

    @DeleteMapping(value = "/deleteById")
    //@PreAuthorize("hasRole('admin')")
    public ResponseEntity deleteById(@RequestParam int id){
        accountingService.deleteById(id);
        return ResponseEntity.ok("User with ID " + id + " has been deleted");
    }

    @PutMapping(value = "/modify")
    public ResponseEntity  modify (@RequestParam String email, String value, String type){
        try {
            User u = accountingService.modifyUser(email, value, type);
            return new ResponseEntity(u, HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>(new ResponseMessage(e.toString()), HttpStatus.BAD_REQUEST);
        }
    }

    @PutMapping(value = "/modifyName")
    public ResponseEntity  modName (@RequestParam String email, String name){
        try {
            User u = getUser(email);
            u.setName(name);
            EM.flush();
            return new ResponseEntity(u, HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>(new ResponseMessage(e.toString()), HttpStatus.BAD_REQUEST);
        }
    }

    @PutMapping(value = "/modifySurname")
    public ResponseEntity  modSurname (@RequestParam String email, String surname){
        try {
            User u = getUser(email);
            u.setSurname(surname);
            EM.refresh(u);
            return new ResponseEntity(u, HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>(new ResponseMessage(e.toString()), HttpStatus.BAD_REQUEST);
        }
    }

    @PutMapping(value = "/modifyEmail")
    public ResponseEntity  modEmail (@RequestParam String old, String New){
        try {
            User u = getUser(old);
            u.setName(New);
            EM.refresh(u);
            return new ResponseEntity(u, HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>(new ResponseMessage(e.toString()), HttpStatus.BAD_REQUEST);
        }
    }

    @PutMapping(value = "/modifyAddress")
    public ResponseEntity  modAddress (@RequestParam String email, String address){
        try {
            User u = getUser(email);
            u.setAddress(address);
            EM.flush();
            return new ResponseEntity(u, HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>(new ResponseMessage(e.toString()), HttpStatus.BAD_REQUEST);
        }
    }

    @PutMapping(value = "/modifyPhone")
    public ResponseEntity  modPhoneNumber (@RequestParam String email, String newNumber){
        try {
            User u = getUser(email);
            u.setPhoneNumber(newNumber);
            EM.refresh(u);
            return new ResponseEntity(u, HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>(new ResponseMessage(e.toString()), HttpStatus.BAD_REQUEST);
        }
    }

}