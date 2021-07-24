package comnos.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import comnos.domain.Criteria;
import comnos.domain.OrderVO;
import comnos.domain.ProductVO;
import comnos.domain.StockVO;
import comnos.mapper.StockMapper;
import lombok.Setter;

@Service
public class StockServiceImpl implements StockService{

	@Setter(onMethod_=@Autowired)
	private StockMapper mapper;
	
	@Override
	public List<StockVO> getList() {
		return mapper.getList();
	}
	
	@Override
	public void update(StockVO stock) {	
		mapper.update(stock);	
	}

	@Override
	public int countEA(StockVO vo) {
		return mapper.countEA(vo);
	}
	
	@Override
	public void addOrder(OrderVO order) {
		// TODO Auto-generated method stub
	}
	
	@Override
	public List<StockVO> getListTest(long sno) {
		return mapper.getListTest(sno);
	}
	@Override
	public List<StockVO> getListWithPaging(Criteria cri) {
		return mapper.getListWithPaging(cri);
	}

}
