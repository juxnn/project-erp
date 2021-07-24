package comnos.mapper;

import java.util.List;

import comnos.domain.Criteria;
import comnos.domain.OrderVO;

public interface OrderMapper {

	public int insertOutOrder(OrderVO order);
	
	public List<OrderVO> getOutList();

	public List<OrderVO> getOrderDetail(String ORDER_NO);
	
	public void statusUpdate(OrderVO order);	//외부발주

	public int checkOrderNo(String ORDER_NO);

}
