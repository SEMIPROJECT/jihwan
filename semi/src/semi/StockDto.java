package semi;

public class StockDto {
	private int code;		// ��ǰ�ڵ�
	private String name;	// tinput���̺� ��ǰ��
	private int count;		// �԰���
	private String idate;	// �԰���
	private int des;		// �μ���ȣ
	
	//private int iname;		// tlist�� tstock���̺� ��ǰ��
	private String cname;	// ����ó��
	private int price;		// �԰�
	private int sprice; 	// ���
	
	
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
