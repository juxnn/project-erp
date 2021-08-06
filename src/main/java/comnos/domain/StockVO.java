package comnos.domain;

import lombok.Data;

@Data
public class StockVO {
	Integer STORE_NO;
	String PRODUCT_NO;
	int STORE_STOCK_EA;
	
	String PRODUCT_NAME;
	String PRODUCT_TYPE;
	String STORE_NAME;

}
