package comnos.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import comnos.domain.Criteria;
import comnos.domain.OrderVO;
import comnos.mapper.StoreOrderMapper;
import lombok.Setter;

@Service
public class StoreOrderServiceImpl implements StoreOrderService{
	
	@Setter(onMethod_=@Autowired)
	private StoreOrderMapper mapper;
	
	@Override
	public void addOrder(OrderVO order) {
		mapper.insert(order);
		
	}@Override
	public List<OrderVO> getList() {
		return mapper.getList();
	}
	@Override
	public List<OrderVO> getListWithStatus(int status) {
		return mapper.getListWithStatus(status);
	}
	
	@Override
	public List<OrderVO> getListWithPaging(Criteria cri) {
		return mapper.getListWithPaging(cri);
	}
	
	@Override
	public List<OrderVO> getOrderList() {
		return mapper.getOrderList();
	}
	
	@Override
	public List<OrderVO> getOrderDetail(String ono) {
		return mapper.getOrderDetail(ono);
	}
	@Override
	public void statusUpdate(OrderVO order) {
		mapper.statusUpdate(order);
	}
	

}
