package comnos.mapper;

import java.util.List;

import comnos.domain.OrderVO;

public interface StoreOutMapper {

	void insert(OrderVO order);

	List<OrderVO> getList();

	int checkOrderNo(String ORDER_NO);

	List<OrderVO> getDetail(String ono);

}
