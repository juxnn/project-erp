package comnos.mapper;

import java.util.List;

import comnos.domain.Criteria;
import comnos.domain.ProductVO;

public interface ProductMapper {

	
	//LIST
	public List<ProductVO> getList();
	
	public List<ProductVO> getListWithPaging(Criteria cri);
	
	public List<ProductVO> getTypeList();

	public int getTotalCount(Criteria cri);
	
	//CRUD
	public int insert(ProductVO vo);
	
	public ProductVO read(String pno);
	
	public int update(ProductVO vo);
	
	public int delete(String pno);
	

}
