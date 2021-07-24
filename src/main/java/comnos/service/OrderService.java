package comnos.service;


import java.util.List;

import comnos.domain.Criteria;
import comnos.domain.OrderVO;

public interface OrderService {

	public void addOutOrder(OrderVO order);
	//외부 발주서
	
	public List<OrderVO> getOutList();
	
	public List<OrderVO> getOrderDetail(String ono);
	
	public void statusUpdate(OrderVO order);

	public boolean checkOrderNo(String orderNo);
	
	

}
