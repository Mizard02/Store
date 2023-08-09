package repositories;

import entities.Product;
import org.springframework.stereotype.Repository;

import java.util.List;
@Repository
public interface ProductRepository {
    List<Product> findByNameContaining(String name);
    List<Product> findByBrand(String brand);
    List<Product> findByBarCode(String name);
    List<Product> findById(int id);
    boolean existsByBarCode(String barCode);
}
