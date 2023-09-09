package com.example.demo.repositories;


import com.example.demo.model.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface UserRepository extends JpaRepository<User, Integer> {
    List<User> findByName(String name);
    Optional<User> findById(long id);
    List<User> findBySurname(String surname);
    List<User> findByNameAndSurname(String name, String surname);
    User findByEmail(String email);
    boolean existsByEmail(String email);
    User deleteByEmail(String email);

    boolean existsById(long id);

}
