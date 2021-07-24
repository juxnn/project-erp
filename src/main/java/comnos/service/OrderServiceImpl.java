package comnos.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import comnos.domain.OrderVO;
import comnos.mapper.OrderMapper;
import lombok.Setter;

@Service
public class OrderServiceImpl implements OrderService{
	
	@Setter(onMethod_=@Autowired)
	private OrderMapper mapper;
	
	@Override //외부 발주서
	public void addOutOrder(OrderVO order) {
		mapper.insertOutOrder(order);
		
	}

	@Override
	public List<OrderVO> getOutList() {
		
		return mapper.getOutList();
	}
	
	
	@Override
	public List<OrderVO> getOrderDetail(String ono) {
		
		return mapper.getOrderDetail(ono);
	}
	
	@Override
	public void statusUpdate(OrderVO order) {
		mapper.statusUpdate(order);	
	}
	
	@Override
	public boolean checkOrderNo(String orderNo) {
		
		if(mapper.checkOrderNo(orderNo) ==1) {
			return true;
		}
		return false;
	}

	
}
