package comnos.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import comnos.domain.OrderVO;
import comnos.mapper.StoreInMapper;
import lombok.Setter;

@Service
public class StoreInServiceImpl implements StoreInService{

	@Setter(onMethod_=@Autowired )
	private StoreInMapper mapper;
	
	@Override
	public List<OrderVO> getListOrder(int storeNo) {
		return mapper.getListOrder(storeNo);
	}
	
	@Override
	public List<OrderVO> getList() {
		return mapper.getList();
	}
	
	@Override
	public void insert(OrderVO order) {
		mapper.insert(order);
		
	}
	
	@Override
	public List<OrderVO> getDetail(String ono) {
		return mapper.getDetail(ono);
	}
	
	
}
