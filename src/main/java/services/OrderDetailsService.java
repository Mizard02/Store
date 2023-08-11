package services;

import entities.OrderDetails;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import repositories.OrderDetailsRepository;

@Service
public class OrderDetailsService {

    @Autowired
    OrderDetailsRepository odRepo;

    public void addToCart(OrderDetails od){
        odRepo.save(od);
    }



}
