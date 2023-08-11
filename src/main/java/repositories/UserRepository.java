package repositories;

import entities.User;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

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
