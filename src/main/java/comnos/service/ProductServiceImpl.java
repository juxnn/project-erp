package comnos.service;

import java.io.File;
import java.io.InputStream;
import java.nio.file.Path;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import comnos.domain.Criteria;
import comnos.domain.FileVO;
import comnos.domain.ProductVO;
import comnos.domain.StockVO;
import comnos.domain.StoreVO;
import comnos.mapper.FileMapper;
import comnos.mapper.ProductMapper;
import comnos.mapper.StockMapper;
import comnos.mapper.StoreMapper;
import lombok.Setter;
import software.amazon.awssdk.auth.credentials.ProfileCredentialsProvider;
import software.amazon.awssdk.core.sync.RequestBody;
import software.amazon.awssdk.profiles.ProfileFile;
import software.amazon.awssdk.services.s3.S3Client;
import software.amazon.awssdk.services.s3.model.DeleteObjectRequest;
import software.amazon.awssdk.services.s3.model.ObjectCannedACL;
import software.amazon.awssdk.services.s3.model.PutObjectRequest;

@Service
public class ProductServiceImpl implements ProductService{
	
	private String bucketName;
	private String profileName;
	private S3Client s3;
	
	@Setter(onMethod_=@Autowired)
	private ProductMapper mapper;
	
	@Setter(onMethod_=@Autowired)
	private FileMapper fileMapper;
	
	@Setter(onMethod_=@Autowired)
	private StoreMapper storeMapper;
	
	@Setter(onMethod_=@Autowired)
	private StockMapper stockMapper;
	
	
	
	@Override
	public double calculateProfit(ProductVO product) {
		
		double inPrice = product.getPRODUCT_IN_PRICE();
		double outPrice = product.getPRODUCT_OUT_PRICE();
		
		double profit = (outPrice - inPrice) / inPrice;
		
		return profit*100;
	}
	@Override
	public double calculateProfitAverage() {
	
		double totalProfit = 0;
		double profitAverage = 0;
		
		List<ProductVO> list = mapper.getList();
		
		for(ProductVO product: list) {
			totalProfit += calculateProfit(product);
		}
		
		profitAverage = totalProfit / list.size();
		return profitAverage;
	}
	
	
	public ProductServiceImpl() {
		this.bucketName = "juxn1";
		this.profileName = "spring1";	
		/*  
		 * create
		 *  /home/tomcat/.aws/credentials
		 */
		
		Path contentLocation = new File(System.getProperty("user.home") + "/.aws/credentials").toPath();
		ProfileFile pf = ProfileFile.builder()
				.content(contentLocation)
				.type(ProfileFile.Type.CREDENTIALS)
				.build();
		ProfileCredentialsProvider pcp = ProfileCredentialsProvider.builder()
				.profileFile(pf)
				.profileName(profileName)
				.build();
		
		this.s3 = S3Client.builder()
				.credentialsProvider(pcp)
				.build();		
	}
	
	
	@Override
	@Transactional
	public void addProduct(ProductVO product) {
		
		mapper.insert(product);
		List<StoreVO> list = storeMapper.getList();
		
		//?????? ????????? ?????? 0?????? ????????????
		for(int i=0; i<list.size(); i++) {
			
			StockVO stock = new StockVO();
			stock.setSTORE_NO(i);
			stock.setPRODUCT_NO(product.getPRODUCT_NO());
			stock.setSTORE_STOCK_EA(0);
			
			stockMapper.insert(stock);
		}	
	}
	
	@Override
	@Transactional
	public void addProduct(ProductVO product, MultipartFile file) {
		addProduct(product);
		
		if(file != null & file.getSize()>0) {
			FileVO vo = new FileVO();
			vo.setPRODUCT_NO(product.getPRODUCT_NO());
			vo.setFILE_NAME(file.getOriginalFilename());
			
			fileMapper.insert(vo);
			upload(product, file);
		}
		
	}

	
	//?????? ????????? ?????? ?????????
	private void upload(ProductVO product, MultipartFile file) {
		
		try(InputStream is = file.getInputStream()){
		
		PutObjectRequest objectRequest = PutObjectRequest.builder()
				.bucket(bucketName)
				.key(product.getPRODUCT_NO() + "/" + file.getOriginalFilename())
				.contentType(file.getContentType())
				.acl(ObjectCannedACL.PUBLIC_READ)
				.build();
		
		s3.putObject(objectRequest,
				RequestBody.fromInputStream(is, file.getSize()));
		
		} catch	(Exception e) {
			throw new RuntimeException(e);
		}
	}
	
	@Override
	public ProductVO get(String pno) {
		ProductVO product= mapper.read(pno);
		
		product.setPRODUCT_PROFIT( calculateProfit(product) );
		product.setAVERAGE_PROFIT( calculateProfitAverage() );
		return product;
	}
	
	@Override
	public boolean modify(ProductVO product) {
		return mapper.update(product) == 1;
	}
	
	@Override
	public boolean remove(String pno) {
		return mapper.delete(pno) == 1;
	}
	
	@Override
	public boolean modify(ProductVO product, MultipartFile file, String fileCheck) {
		if(file !=null & file.getSize()>0) {
			//s3 ?????? ??? ??? ?????????
			ProductVO oldProduct = mapper.read(product.getPRODUCT_NO());
			removeFile(oldProduct);
		}
		return false;
	}
	
	private void removeFile(ProductVO vo) {
		
		String key = vo.getPRODUCT_NO() + "/" + vo.getFILE_NAME();
        DeleteObjectRequest deleteObjectRequest = DeleteObjectRequest.builder()
                .bucket(bucketName)
                .key(key)
                .build();
        
        s3.deleteObject(deleteObjectRequest);
	}
	
	@Override
	public List<ProductVO> getList() {
		return mapper.getList();
	}
	
	@Override
	public List<ProductVO> getTypeList() {
		return mapper.getTypeList();
	}
	
	@Override
	public List<ProductVO> getListWithPaging(Criteria cri) {
		
		return mapper.getListWithPaging(cri);
	}
}
