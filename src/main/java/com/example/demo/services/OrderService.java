package com.example.demo.services;

import com.example.demo.model.*;
import com.example.demo.exceptions.*;
import com.example.demo.repositories.OrderDetailsRepository;
import com.example.demo.repositories.OrderRepository;
import com.example.demo.repositories.UserRepository;
import exceptions.UserNotExist;
import jakarta.persistence.EntityManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class OrderService {

    @Autowired
    private UserRepository ur;

    @Autowired
    private OrderRepository or;

    @Autowired
    private EntityManager entityManager;

    @Autowired
    private OrderDetailsRepository odr;

    @Transactional(readOnly = false, propagation = Propagation.REQUIRED, rollbackFor = {QuantityProductUnavailableException.class})
    public Order addOrder(Order o) throws QuantityProductUnavailableException {
        Order result = or.save(o);
        for ( OrderDetails od : result.getOrderDetails() ) {
            //od.setOrder(result);
            OrderDetails justAdded = odr.save(od);
            //entityManager.refresh(justAdded);
            Product product = justAdded.getProduct();
            int newQuantity = product.getQuantity() - od.getQuantity();
            if ( newQuantity < 0 ) {
                throw new QuantityProductUnavailableException();
            }
            product.setQuantity(newQuantity);
            //entityManager.refresh(od);
        }
        //entityManager.refresh(result);
        return result;
    }

    @Transactional(readOnly = true)
    public List<Order> getOrdersByUser(User user) throws UserNotExist {
        if ( !ur.existsById(user.getId()) ) {
            throw new UserNotExist();
        }
        return or.findByClient(user);
    }

    @Transactional(readOnly = true)
    public List<Order> getAllOrders() {
        return or.findAll();
    }

    @Transactional(readOnly = false)
    public void deleteAll() {
        or.deleteAll();
        odr.deleteAll();
    }

}
