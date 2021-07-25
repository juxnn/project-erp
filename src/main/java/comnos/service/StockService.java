package comnos.service;

import java.util.List;

import org.springframework.web.bind.annotation.PostMapping;

import comnos.domain.Criteria;
import comnos.domain.OrderVO;
import comnos.domain.ProductVO;
import comnos.domain.StockVO;



public interface StockService {

	public List<StockVO> getList();

	public void update(StockVO stock);

	public int countEA(StockVO stock);

	public void addOrder(OrderVO order);

	public List<StockVO> getListTest(long sno);

	public List<StockVO> getListWithPaging(Criteria cri);
	

}
