package com.example.demo.repositories;


import com.example.demo.model.Jacket;
import com.example.demo.model.Size;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
@Repository
public interface JacketRepository extends JpaRepository<Jacket, Integer> {

    List<Jacket> findBySize(Size size);
}
