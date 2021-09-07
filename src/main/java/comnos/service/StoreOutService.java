package comnos.service;

import java.util.List;

import comnos.domain.OrderVO;

public interface StoreOutService {

	void addStoreOutOrder(OrderVO order);

	List<OrderVO> getList();
	
	List<OrderVO> getDetail(String ono);

}
