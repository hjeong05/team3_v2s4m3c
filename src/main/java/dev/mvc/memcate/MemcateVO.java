package dev.mvc.memcate;

public class MemcateVO {
  /** 멤버 카테고리 번호 */
  private int memcateno;
  /**  멤버 카테고리 이름 */
  private String name;
  /** 출력 순서 */
  private int seqno;
  /** 출력 모드 */
  private String visible;
  /** 등록일 */
  private String rdate;
  /** 등록된 회원수*/
  private int cnt;
  
  public int getMemcateno() {
    return memcateno;
  }
  public void setMemcateno(int memcateno) {
    this.memcateno = memcateno;
  }
  public String getName() {
    return name;
  }
  public void setName(String name) {
    this.name = name;
  }
  public int getSeqno() {
    return seqno;
  }
  public void setSeqno(int seqno) {
    this.seqno = seqno;
  }
  public String getVisible() {
    return visible;
  }
  public void setVisible(String visible) {
    this.visible = visible;
  }
  public String getRdate() {
    return rdate;
  }
  public void setRdate(String rdate) {
    this.rdate = rdate;
  }
  public int getCnt() {
    return cnt;
  }
  public void setCnt(int cnt) {
    this.cnt = cnt;
  }
  
  
  
  
}
