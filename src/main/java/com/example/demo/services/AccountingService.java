package com.example.demo.services;


import com.example.demo.model.User;
import com.example.demo.repositories.UserRepository;
import exceptions.UserNotExist;
import jakarta.persistence.EntityManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import exceptions.MailUserAlreadyExistsException;
import java.util.List;

@Service
public class AccountingService {
    @Autowired
    private UserRepository userRepository;

    @Autowired
    private EntityManager EM;

    @Transactional(readOnly = false, propagation = Propagation.REQUIRED)
    public User registerUser(User user) throws MailUserAlreadyExistsException {
        if ( userRepository.existsByEmail(user.getEmail()) ) {
            throw new MailUserAlreadyExistsException();
        }
        return userRepository.save(user);
    }

    @Transactional(readOnly = true)
    public List<User> getAllUsers() {
        return userRepository.findAll();
    }

    public User getUser(String Email) throws UserNotExist {
        User res;
        if(userRepository.existsByEmail(Email))
            res = userRepository.findByEmail(Email);
        else
            throw new UserNotExist();
        return res;
    }

    @Transactional
    public void deleteAllUsers() {
        userRepository.deleteAll();
    }

    @Transactional
    public User modifyUser(String email, String value, String type){
        try {
            User u = getUser(email);
            switch (type) {
                case "name":
                    u.setName(value);
                    break;
                case "surname":
                    u.setSurname(value);
                    break;
                case "address":
                    u.setAddress(value);
                    break;
                case "phoneNumber":
                    u.setPhoneNumber(value);
                    break;
                case "email":
                    u.setEmail(value);
                    break;
            }
            EM.flush();
            return u;
        } catch (UserNotExist e) {
            throw new RuntimeException(e);
        }
    }

    @Transactional
    public void deleteById(int id){
        userRepository.deleteById(id);
    }
}

