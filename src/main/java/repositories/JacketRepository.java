package repositories;

import entities.Jacket;
import entities.Product;
import entities.Size;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface JacketRepository extends JpaRepository<Jacket, Integer> {

    List<Jacket> findBySize(Size size);
}
