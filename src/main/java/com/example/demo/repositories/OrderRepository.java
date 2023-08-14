package com.example.demo.repositories;


import com.example.demo.model.Order;
import com.example.demo.model.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.Date;
import java.util.List;
@Repository
public interface OrderRepository extends JpaRepository<Order, Integer> {
    List<Order> findByTime(Date orderTime);

    boolean existsByTime(Date time);
    boolean existsByClient(User u);
    @Query("select p from Order p where p.time > ?1 and p.time < ?2 and p.client = ?3")
    List<Order> findByClientInPeriod(Date startDate, Date endDate, User user);

    List<Order> findByClient(User client);

}
