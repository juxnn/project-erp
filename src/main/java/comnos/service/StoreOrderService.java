package comnos.service;

import java.util.List;

import comnos.domain.Criteria;
import comnos.domain.OrderVO;

public interface StoreOrderService {
	
	
	public void addOrder(OrderVO order);
	//내부 발주서

	public List<OrderVO> getList();

	public List<OrderVO> getListWithPaging(Criteria cri);
	
	public List<OrderVO> getOrderList();
	
	public List<OrderVO> getOrderDetail(String ono);

	public void statusUpdate(OrderVO order);


}
