package comnos.service;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import comnos.domain.Criteria;
import comnos.domain.ProductVO;

public interface ProductService {

	//CRUD
	public void addProduct(ProductVO product);
	public ProductVO get(String pno);
	public boolean modify(ProductVO product);
	public boolean remove(String pno);

	//파일 업로드	
	public void register(ProductVO product, MultipartFile file);
	public boolean modify(ProductVO product, MultipartFile file, String fileCheck);

	//리스트
	
	public List<ProductVO> getList();
	public List<ProductVO> getTypeList();
	
	public List<ProductVO> getListWithPaging(Criteria cri);
}
