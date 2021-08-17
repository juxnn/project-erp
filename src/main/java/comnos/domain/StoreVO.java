package comnos.domain;

import lombok.Data;

@Data
public class StoreVO {

	private long STORE_NO;
	private String STORE_NAME;
	private String STORE_ADDRESS;
	private String STORE_ADDRESS_SUB;
	private String STORE_PHONE;
	private Integer EMP_COUNT;
	
}
