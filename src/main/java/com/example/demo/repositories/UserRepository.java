package com.example.demo.repositories;


import com.example.demo.model.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
@Repository
public interface UserRepository extends JpaRepository<User, Integer> {
    List<User> findByFirstName(String firstName);
    List<User> findById(int id);
    List<User> findByLastName(String lastName);
    List<User> findByFirstNameAndLastName(String firstName, String lastName);
    User findByEmail(String email);
    List<User> findByCode(String code);
    boolean existsByEmail(String email);
    User deleteByEmail(String email);

}
