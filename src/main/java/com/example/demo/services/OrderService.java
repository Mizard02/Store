package com.example.demo.services;

import com.example.demo.DTO.OrderDTO;
import com.example.demo.model.*;
import com.example.demo.exceptions.*;
import com.example.demo.repositories.OrderDetailsRepository;
import com.example.demo.repositories.OrderRepository;
import com.example.demo.repositories.ProductRepository;
import com.example.demo.repositories.UserRepository;
import exceptions.UserNotExist;
import jakarta.persistence.EntityManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

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

    @Autowired
    private ProductRepository pr;

    @Transactional(readOnly = false, propagation = Propagation.REQUIRED, rollbackFor = {Exception.class})
    public OrderDTO addOrder(List<OrderDetails> orderDetails, User user) throws  Exception {
        Order o = new Order();
        List<OrderDetails> oDs=new ArrayList<>();;
        Optional<User> userManaged = ur.findById(user.getId());
        if(! userManaged.isPresent())
            throw new Exception();
        o.setClient(user);
        for ( OrderDetails od : orderDetails ) {
            Optional<Product> prod = pr.findById(od.getProduct().getId());
            if(! prod.isPresent())
                throw new Exception("The product is finished");
            if(od.getProduct().getPrice()!=prod.get().getPrice())
                throw new Exception("The price has changed");
            if(od.getQuantity()> prod.get().getQuantity())
                throw new Exception("This quantity is not available");
            else{
               if(od.getProduct().getId() == prod.get().getId()){
                   int newQuantity = prod.get().getQuantity() - od.getQuantity();
                   prod.get().setQuantity(newQuantity);
                   OrderDetails justAdded = odr.save(od);
                   odr.flush();
                   oDs.add(justAdded);
               }
            }
        }
        o.setOrderDetails(oDs);
        or.save(o);
        return new OrderDTO(o.getClient().getEmail(), oDs);
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
