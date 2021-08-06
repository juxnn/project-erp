package comnos.mapper;

import java.util.List;

import comnos.domain.Criteria;
import comnos.domain.StockVO;

public interface StockMapper {

	public List<StockVO> getList();
	
	public int insert(StockVO stock);
	
	public int exist(String PRODUCT_NO);

	public void update(StockVO stock);

	public int countEA(StockVO stock);

	public List<StockVO> getListTest(long STORE_NO);

	public List<StockVO> getListWithPaging(Criteria cri);

	public List<StockVO> search(StockVO vo);

}
