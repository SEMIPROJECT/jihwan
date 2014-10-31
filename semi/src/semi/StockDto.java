package semi;

public class StockDto {
	private int code;		// 상품코드
	private String name;	// tinput테이블 상품명
	private int count;		// 입고갯수
	private String idate;	// 입고일
	private int des;		// 부서번호
	
	//private int iname;		// tlist와 tstock테이블 상품명
	private String cname;	// 공급처명
	private int price;		// 입고가
	private int sprice; 	// 출고가
	
	
	public int getCode() {
		return code;
	}
	public void setCode(int code) {
		this.code = code;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}
	public String getIdate() {
		return idate;
	}
	public void setIdate(String idate) {
		this.idate = idate;
	}
	public int getDes() {
		return des;
	}
	public void setDes(int des) {
		this.des = des;
	}
	public String getCname() {
		return cname;
	}
	public void setCname(String cname) {
		this.cname = cname;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public int getSprice() {
		return sprice;
	}
	public void setSprice(int sprice) {
		this.sprice = sprice;
	}	
}
