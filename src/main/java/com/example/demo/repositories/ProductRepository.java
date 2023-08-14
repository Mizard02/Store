package com.example.demo.repositories;


import com.example.demo.model.Product;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
@Repository
public interface ProductRepository extends JpaRepository<Product, Integer> {
    List<Product> findByNameContaining(String name);
    List<Product> findByBarCode(String name);
    List<Product> findById(long id);
    boolean existsByBarCode(String barCode);

}