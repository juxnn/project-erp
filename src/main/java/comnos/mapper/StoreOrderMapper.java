package comnos.mapper;

import java.util.List;

import comnos.domain.Criteria;
import comnos.domain.OrderVO;

public interface StoreOrderMapper {
	
	public void insert(OrderVO order);
	
	public List<OrderVO> getList();			//상품 list 까지 가져오기
	
	public List<OrderVO> getListWithStatus(int status);
	
	public List<OrderVO> getOrderList();	//발주서 목록만 가져오기
	
	public List<OrderVO> getListWithPaging(Criteria cri);
	
	public List<OrderVO> getOrderDetail(String ORDER_NO);
	
	public void statusUpdate(OrderVO order);

	public int checkOrderNo(String ORDER_NO);

}
