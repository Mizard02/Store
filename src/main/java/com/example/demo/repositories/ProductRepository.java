package com.example.demo.repositories;


import com.example.demo.model.Product;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface ProductRepository extends JpaRepository<Product, Integer> {
    List<Product> findByNameContaining(String name);
    List<Product> findByBarCode(String name);
    Optional<Product> findById(long id);
    boolean existsByBarCode(String barCode);
}
