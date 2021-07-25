package comnos.mapper;

import java.util.List;

import comnos.domain.OrderVO;

public interface StoreInMapper {

	void insert(OrderVO order);

	List<OrderVO> getList();
	
	List<OrderVO> getListOrder();
	
	int checkOrderNo(String orderNo);

}
