package comnos.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import comnos.domain.OrderVO;
import comnos.mapper.StoreOutMapper;
import lombok.Setter;

@Service
public class StoreOutServiceImpl implements StoreOutService{

	@Setter(onMethod_=@Autowired )
	private StoreOutMapper mapper;
	
	@Override
	public void addStoreOutOrder(OrderVO order) {
		mapper.insert(order);
	}
	
	@Override
	public List<OrderVO> getList() {
		return mapper.getList();
	}
	
	@Override
	public List<OrderVO> getDetail(String ono) {
		return mapper.getDetail(ono);
	}
}
