package dev.mvc.productcate;

public class ProductcateVO {
  /**  카테고리 번호 */
  private int productcateno;
  /**  카테고리 이름 */
  private String name;
  /**  출력 순서 */
  private int seqno;
  /**  등록된 글 수 */
  private int cnt;
  public int getProductcateno() {
    return productcateno;
  }
  public void setProductcateno(int productcateno) {
    this.productcateno = productcateno;
  }
  public String getName() {
    return name;
  }
  public void setName(String name) {
    System.out.println("--> ProductcateVO setName(\""+name+"\") 호출됨.");
    this.name = name;
  }
  public int getSeqno() {
    return seqno;
  }
  public void setSeqno(int seqno) {
    this.seqno = seqno;
  }
  public int getCnt() {
    return cnt;
  }
  public void setCnt(int cnt) {
    this.cnt = cnt;
  }
  
}
