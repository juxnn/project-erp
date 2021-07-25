package comnos.service;

import java.util.List;

import comnos.domain.OrderVO;

public interface StoreInService {

	void insert(OrderVO order);

	List<OrderVO> getListOrder();

	List<OrderVO> getList();
}
