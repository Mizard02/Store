package repositories;

import entities.Order;
import entities.OrderDetails;
import entities.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.Date;
import java.util.List;
@Repository
public interface OrderRepository extends JpaRepository<Order, Integer> {
    List<Order> findByOrderTime(Date orderTime);

    boolean existByOrderTime(Date orderTime);

    boolean existByBuyer(User Buyer);
    @Query("select p from Order p where p.orderTime > ?1 and p.orderTime < ?2 and p.buyer = ?3")
    List<Order> findByBuyerInPeriod(Date startDate, Date endDate, User user);

    List<Order> findByBuyer(User user);

}
