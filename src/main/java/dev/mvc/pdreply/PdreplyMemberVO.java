package dev.mvc.pdreply;

public class PdreplyMemberVO {
  /** ���̵� */
  private String id = "";  
  /** ��� ��ȣ */
  private int pdreplyno;
  /** ���� �� ��ȣ */
  private int pdcontentsno;
  /** ȸ�� ��ȣ */
  private int memberno;
  /** ���� */
  private int starcnt;
  /** ���� */
  private String content;
  /** �н����� */
  private String passwd;
  /** ����� */
  private  String rdate;
  public String getId() {
    return id;
  }
  public void setId(String id) {
    this.id = id;
  }
  public int getPdreplyno() {
    return pdreplyno;
  }
  public void setPdreplyno(int pdreplyno) {
    this.pdreplyno = pdreplyno;
  }
  public int getPdcontentsno() {
    return pdcontentsno;
  }
  public void setPdcontentsno(int pdcontentsno) {
    this.pdcontentsno = pdcontentsno;
  }
  public int getMemberno() {
    return memberno;
  }
  public void setMemberno(int memberno) {
    this.memberno = memberno;
  }
  public int getStarcnt() {
    return starcnt;
  }
  public void setStarcnt(int starcnt) {
    this.starcnt = starcnt;
  }
  public String getContent() {
    return content;
  }
  public void setContent(String content) {
    this.content = content;
  }
  public String getPasswd() {
    return passwd;
  }
  public void setPasswd(String passwd) {
    this.passwd = passwd;
  }
  public String getRdate() {
    return rdate;
  }
  public void setRdate(String rdate) {
    this.rdate = rdate;
  }

}
