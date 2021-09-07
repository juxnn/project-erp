# :pushpin: Comnos(ERP System)
>전사적 자원관리 System  
>http://54.180.128.201/comnos/main/home


![컴노스 PPT 최종 수정본](https://user-images.githubusercontent.com/80299163/132378386-d9574d57-05e1-403c-a986-ced03548af6c.png)

</br>

## 1. 제작 기간 & 참여 인원
- 2021년 7월 12일 ~ 8월 21일 (6주)
- 개인 프로젝트

</br>

## 2. 사용 기술
#### `Back-end`
  - Java 8
  - Spring Framework 5.0.7
  - MySQL 10.3.28
  - Spring Security
#### `Front-end`
  - HTML
  - CSS
  - JavaScript

</br>

## 3. ERD 설계

![ERD](https://user-images.githubusercontent.com/80299163/132377493-f0ff99b7-5583-4466-9aff-9b683b8a61ef.jpg)


## 4. 프로젝트 핵심 설명
>로그인한 사원의 부서정보에 따라, 접근 가능한 페이지가 달라집니다.<br>
>직급에 따라 몇몇 직급은 특정 업무에는 접근할 수 없습니다.

<details>
<summary><b> 프로젝트 핵심 설명 펼치기</b></summary>
<div markdown="1">

### 4.1. 프로젝트 설명
![수정1](https://user-images.githubusercontent.com/80299163/132401792-7d9d0076-c9df-4b33-918a-ca60e1334708.png)

![수정2](https://user-images.githubusercontent.com/80299163/132402422-acff080f-a206-4570-b59d-82668bd74288.png)


### 4.2. 내부 발주서 흐름
![수정3](https://user-images.githubusercontent.com/80299163/132401893-fd084eaa-4cde-4b2a-ac72-853fc1bb71fe.png)

### 4.3. 외부 발주서 흐름

![수정4](https://user-images.githubusercontent.com/80299163/132401942-e0eb3d85-7fe8-425b-ab9e-79cfd977df62.png)

### 4.4. 그 외

* 사원 정보 등록 & 수정
* 퇴사 처리(권한 제거)
* 매장, 상품 정보 등록
* 외부 API 연동(카카오 주소찾기, 카카오 맵) 
* Spring SMTP Server 이용하여 메일 전송 (비밀번호 재설정)
* Spring Security를 이용한 권한 설정 및 관리
* AWS S3를 이용한 이미지 업로드 및 출력

</div>
</details>

</br>


## 5. 트러블 슈팅
### 5.1. 사원번호 자동생성 기능에서 중복처리 체크
- 사원 정보를 생성할 때, 입사년도, 입사일 8자리 + 랜덤 2자리 숫자로 사원번호를 자동생성하는 기능을 만들었습니다.
- 사원번호가 PK로 설정되어있었기 때문에, 간혹 같은 입사년도, 입사일에 대한 정보를 만들 때 중복 에러가 떴습니다.

- 중복을 어떻게 처리할까 고민을 했는데, [[Algorithm] JAVA로 중복이 없고, 순서도 없는 조합(Combination) 구하기!](https://limkydev.tistory.com/156) 라는 글을 읽고, 재귀함수를 통하여 해결했습니다.


<details>
<summary><b>재귀 함수</b></summary>
<div markdown="1">

~~~java
/**
 * 사원정보 생성 (ComputeServiceImpl.java)
 */

	@Override
	public long mimeEmpCode(Date empDate) {
		
		Random random = new Random();
		int x = random.nextInt(99);
		String ranNum = String.format("%02d", x);

		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMdd");
		String dateStr = dateFormat.format(empDate);
		
		long empCode = Long.parseLong(dateStr + ranNum);
		
		
		if(employeeMapper.checkEmpCode(empCode) == 1) {
			return mimeEmpCode(empDate);
		}else {
			return empCode;
		}
	}
~~~

</div>
</details>

### 5.2. 예외처리를 어디서 해줄것인가에 대한 고민
- 발주서를 작성할 때, 상품 수량이 0이거나, 음수일 때 예외처리를 해야하는 작업을 고민하고 있었습니다.
- 클라이언트(브라우저)에서 JavaScript로 유효성 검사를 하는게 효율적일지, 서버사이드에서 검사를하는게 효율적인지 궁금해서 검색해보았습니다.
- [프론트엔드에서"만" 유효성 검사가 문제인 이유](https://jojoldu.tistory.com/157)의 글을 읽던 중 댓글을 보고 클라이언트와, 서버사이드 양쪽에서 유효성 검사를 해야한다는 것을 이해했습니다.
<details>
<summary><b>클라이언트 유효성 검사</b></summary>
<div markdown="1">

~~~java
/**
 * 발주서 작성 (store-order/form.jsp)
 * javascript Math.floor 함수를 이용하여 0이상의 값만 작성되게 하였습니다. 
 */

	<form method="post" action="${appRoot }/store-order/order">
	<table class="table table-striped">
		<thead>
		</thead>
		<tbody id="product-table-body">
			<tr class="d-flex">
				<th class="col-3">타입</th>
				<th class="col-7">상품명</th>
				<th class="col-2">수량</th>
			</tr>
			<tr class="d-flex">
				<td class="col-3">
					<select id="product-type-select" onchange="changeTypeSelect(this)">
						<option value="">상품 TYPE</option>
						<c:forEach items="${productTypeList }" var="type">
							<option id="${type.PRODUCT_TYPE }"
								value="${type.PRODUCT_TYPE }">${type.PRODUCT_TYPE }</option>
						</c:forEach>
					</select>
				</td>
				<td class="col-7">
					<select class="product-product-select" name='products' style='width:100%'>
						<option value="">타입을 먼저 선택하세요</option>
					</select>
				</td>
				<td class="col-2">
					<input type='number' name='ORDER_EA' onchange='this.value = Math.floor(Math.max(this.value,1))' style="width:50px" value="1">
				</td>
			</tr>
		</tbody>
	</table>
	<button id="product-add-btn" type="button" class="btn btn-secondary" >상품 추가하기</button>
	<input type="number" name="STORE_NO" value="${employee.STORE_NO }" hidden="hidden">
	<input type="number" name="EMP_CODE" value="${employee.EMP_CODE }" hidden="hidden">
	
	<sec:authorize access="!hasAnyRole('ROLE_AM', 'ROLE_ST')">
		<button class="btn btn-primary" type="submit">제출</button>
	</sec:authorize>
	<sec:authorize access="hasAnyRole('ROLE_AM', 'ROLE_ST')">
		<div class="not-message">대리, 사원은 발주서를 작성할 직급이 아닙니다.</div>
	</sec:authorize>
</form>
~~~

</div>
</details>


<details>
<summary><b>서버사이드 유효성 검사</b></summary>
<div markdown="1">

~~~java
/**
 * 발주서 작성 (StoreOrderController)
 */

	@PostMapping("/order")
	@Transactional
	public String addOrder(OrderVO order, String[] products, int[] ORDER_EA, RedirectAttributes rttr) {
		
		//발주수량 유효성 검사(상품의 발주량이 0개인 경우가 있으면 에러 메세지처리)
		for(int i=0; i<products.length; i++) {
			if(ORDER_EA[i] == 0) {
				rttr.addFlashAttribute("message", "수량이 0개인 상품이 있습니다.");
				return "redirect:/store-order/order";
			}
		}
		
		int number = 1;
		//주문번호 채번 서비스 (B01)번부터 시작		
		String ono = computeService.mimeOrderNumberB(number);
		order.setORDER_NO(ono);
		
		for(int i=0; i<products.length; i++) {
			order.setPRODUCT_NO( products[i] );
			order.setORDER_EA( ORDER_EA[i] );
			service.addOrder(order);	//내부 발주서 작성
		}
		rttr.addFlashAttribute("message", "발주서 제출이 되었습니다.");
		return "redirect:/store-order/list";
	}
~~~

</div>
</details>

<br>

## 6. 회고 / 느낀점

정신없이 달려왔습니다. 부족한점을 많이 느꼈습니다.
프로젝트에 대한 설명보다 부족한점을 적어내릴 부분이 훨씬 많은 프로젝트 같습니다.

0. 기록의 중요성. 많은 부분들을 고민했는데, 코딩에만 정신팔려 오다보니 기억이 잘 나질 않는다.
1. 설계의 중요성. 계속 수정에 수정을 반복하다보니 꼬인다.
2. REST API를 신경쓰지 않은 URI 구성. method명과 field명의 규칙성에 대한 고찰 부족?
3. ajax와 submit 어떤것이 좋을까?

