package comnos.domain;

import lombok.Data;

@Data
public class ProductVO {
	
	private String PRODUCT_NO;
	private String PRODUCT_NAME;
	private String PRODUCT_TYPE;
	private long PRODUCT_IN_PRICE;
	private long PRODUCT_OUT_PRICE;
	private String PRODUCT_DETAIL;
	
	private String FILE_NAME;
}
