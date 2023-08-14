package com.example.demo.repositories;


import com.example.demo.model.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
@Repository
public interface UserRepository extends JpaRepository<User, Integer> {
    List<User> findByName(String name);
    List<User> findById(int id);
    List<User> findBySurname(String surname);
    List<User> findByNameAndSurname(String name, String surname);
    User findByEmail(String email);
    boolean existsByEmail(String email);
    User deleteByEmail(String email);

}
